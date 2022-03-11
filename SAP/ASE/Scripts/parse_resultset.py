# -*- coding: utf-8 -*-
# import sys
import os
import re
from openpyxl import Workbook
from openpyxl.utils import get_column_letter
# sys.setdefaultencoding('utf-8')


def read_results_file(rs_file, defined_sections):
    with open(rs_file, 'r', encoding='utf-8', errors='ignore') as result_set:
        cycle = 0
        raw_data = result_set.read()
        sections = re.split('\((\d+).+affected\)', raw_data)
        master_idx = 1
        last_group = 1
        for sec in sections:
            if master_idx % len(defined_sections) == 0: index = len(defined_sections)
            else: index = master_idx % len(defined_sections)
            if len(sec) < 6: continue
            if index == 1: 
                wb.close()
                del(ws)
                del(wb)
                if last_group != master_idx: 
                    last_group += 1
                master_idx += 1
                cycle += 1
                wb = Workbook()
                continue
            print(str(master_idx), defined_sections[index-1])
            print('length', str(len(sec)))
            print(sec[:200])
            master_idx += 1 


def ProcessQueryMetrics(input_folder, output_folder):
    fields = []
    counter = 1
    for dir_path, dir_names, file_names in walk(os.path.abspath(input_folder)):
        for qrymtr_file in file_names:
            file_name_read = dir_path + '\\' + qrymtr_file
            file_name_write = output_folder + '\\' + qrymtr_file.replace('bcp', 'txt')
            with open(file_name_read, "r") as r, open(file_name_write, "w") as w:
                for line in r:
                    if counter > 100:
                        break
                    print('******************************')
                    print('counter is ', str(counter))
                    print(line)
                    w.write(line)
                    counter += 1

        
section_list = ['todays date', 'master..sysprocesses', 'master..syslocks', 'master..syslogshold', 'master..systransactions', 'sp_monitorconfig']
#read_results_file('C:\\_Run\\Project\\KBC\\BS_threshold_PROD\\SAPdiag_PROD.log', section_list)
#read_results_file('C:\\Users\\jirib\\Google Drive\\Work\\Customers\\CRA\\logs\\echodb.log', section_list)
#read_results_file('/mnt/c/_Run/Project/KBC/BS_threshold_PROD/SAPdiag_PROD.log', section_list)
ProcessQueryMetrics('C:\\_Run\\Project\\CRa\\querymetrics\\', 'C:\\_Run\\Project\\CRa\\qry_processed')