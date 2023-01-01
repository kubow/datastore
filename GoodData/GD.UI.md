React-based JavaScript library (public cloud / on-premises) that works with:
- hosted GoodData platform
- cloud-native analytics platform

Start points:

- Clear
	- [Getting started](https://sdk.gooddata.com/gooddata-ui/docs/quickstart.html)
	- https://github.com/gooddata/gooddata-create-gooddata-react-app
- Prebuilt
	- https://github.com/gooddata/gooddata-plugin-examples
- Introduction
	- [GD Cloud integration introduction](https://sdk.gooddata.com/gooddata-ui/docs/cloud_introduction.html)
	- [GD.CN integration introduction](https://sdk.gooddata.com/gooddata-ui/docs/cloudnative_introduction.html)

[Main point for UI.SDK (github.com)](https://github.com/gooddata/gooddata-ui-sdk)



```bash
yarn refresh-md
# brings up actual workspace content
```

```javascript
import * as Md from "../md/full"
// can be further used
{Md.Dashboards.Name}
```


## Examples

- [UI.SDK Examples Gallery](https://gdui-examples.herokuapp.com/)
	- [InsightView](https://gdui-examples.herokuapp.com/insightView/insightView-by-identifier)
	- [Simple Dashboard](https://gdui-examples.herokuapp.com/dashboard/simple)
	- [AttributeFilter](https://gdui-examples.herokuapp.com/attribute-filter-components/attribute-filter)
	- [Export Data](https://gdui-examples.herokuapp.com/export)


Two main components:
- [InsightView](https://sdk.gooddata.com/gooddata-ui/docs/8.3.0/visualization_component.html)
- [DashboardView](https://sdk.gooddata.com/gooddata-ui/docs/8.3.0/dashboard_view_component.html)

[Accelerator toolkit](https://sdk.gooddata.com/gooddata-ui/docs/create_new_application.html) offers a pre-built [npm package](https://www.npmjs.com/package/@gooddata/create-gooddata-react-app) with this workflow:


```shell
npx @gooddata/create-gooddata-react-app my-app  #hosted GD platform
#? What is your hostname? <Use your domain URL> / <GD.CN endpoint incl. protocol, typically http://localhost:3000/>
#? What is your application's desired flavor? JavaScript
cd my-app
yarn start
```



### Embedding

- You can embed your dashboards via [React SDK](https://sdk.gooddata.com/gooddata-ui/docs/about_gooddataui.html).
- You can embed via iframe (top right - embed - iframe - copy)
	- Hide navigation panel: ?showNavigation=false
	- Hide filter bar: ?hideControl=[filterBar]
	- Hide list of visualizations: ?hideControl=[widgetsCatalogue]
	- Hide top bar: ?hideControl=[widgetsCatalogue]

Basic address: https://<your-domain>.com/dashboards/embedded/#/workspace/<workspace-id>/dashboard/<dashboard-id>