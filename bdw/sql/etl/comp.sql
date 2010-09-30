select value
from   component_parameters, 
       component
where  component.component_id = component_parameters.component_id
and    component.component_name = 'ETL'
and    parameter = 'Installation Host' union all
select value
from   component_parameters, 
       component
where  component.component_id = component_parameters.component_id
and    component.component_name = 'ETL'
and    parameter = 'Installation Directory';

