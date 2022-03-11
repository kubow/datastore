create proc sp_extrapwdchecks 
( 
@caller_password varchar(30) = NULL, -- the current password of caller    
@new_password    varchar(30), -- the new password of the target acct 
@loginame        varchar(30) = NULL -- user to change password on
)
as 

begin   
declare @current_time datetime,   
        @encrypted_old_pwd varbinary(30),   
        @encrypted_new_pwd varbinary(30),   
        @salt varchar(8),   
        @changedby varchar(30),   
        @cutoffdate datetime       

        select @changedby = suser_name()   
        select @salt = null       
        
        -- NOTE : caller_password and/or loginame arguments can be null. 
        -- In these cases, password history checks should be skipped.  
        
        -- @loginame is null when SSO creates a new login account 
        -- using “create login” command.      
        
        -- @caller_password is null when   
        
        -- 1. SSO creates a new login account using 
        -- “create login” command.   
        
        -- 2. SSO modifies the login account’s password using 
        -- “alter login … modify password” command.    
        
        -- Business logic for custom password checks should be 
        -- implemented here.   

        -- If there is no need to maintain password history, return 
        -- from here.       

        if (@loginame is NULL)   
        begin       
            return 0   
        end           
        
        -- Change this line according to the needs of your installation.   

        -- This checks below keep history of 12 months only.       

        select @current_time = getdate(),@cutoffdate = dateadd
           (month, -12, getdate())       

        delete master..pwdhistory   
        where name = @loginame   
        and pwdate < @cutoffdate       

        select @salt = substring(password, 1, 8) from master..pwdhistory   
            where pwdate =    
                (select max(pwdate) from master..pwdhistory where   
                name=@loginame)and name=@loginame       

        if @salt is null   
        begin 
  
            select @salt = substring(hash
                (password_random(8), 'sha1'), 1, 8)   
        end       

        select @encrypted_new_pwd = @salt + hash
                (@salt + @new_password, 'sha1')       

        if not exists ( select 1 from master..pwdhistory   
            where name = @loginame and password = @encrypted_new_pwd )       

        begin   
            -- new password has not been used before   

            if (@loginame != @changedby)   
            begin                 
                return 0   
            end       

            -- Save old password   
            select @encrypted_old_pwd = @salt + hash
                (@salt + @caller_password, 'sha1')   
            insert master..pwdhistory   
                select @loginame, 
                    @encrypted_old_pwd,@current_time, @changedby   
            return (0)   
        end   
        else  
        begin   
               raiserror 22001 --user defined error message   
        end       

    end   
    go    