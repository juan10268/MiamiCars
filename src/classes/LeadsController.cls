@RestResource(urlMapping='/abc')
global class LeadsController {
	public Lead oLead {get;set;}
	public Car__c oCar {get;set;}
	
	public LeadsController(){
		oLead = new Lead();
		oCar = new Car__c();
	}
	
	public PageReference saveLead(){
    	if(oLead != null){
	    	insert oLead;
    	}
	    PageReference pr = new PageReference('/apex/LeadsPage');
	    pr.setRedirect(true);    
	    return pr;	        		
    }
		
	global static Map<String, String> getLeads(){
		RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String jSonLeads= '';
        List<Lead> leadList=new List<Lead>();  
        leadList=[select Id, Name from Lead];
        jSonLeads= JSON.Serialize(leadList);
        List<Lead> result = (List<Lead>)JSON.deserialize(jSonLeads , List<Lead>.class);
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('','Select Lead'));
        Map<String, String> mapLeads = new Map<String, String>();
        for(Lead lead: result){
        	options.add(new SelectOption(lead.Id, lead.Id));
        	mapLeads.put(lead.Name, lead.Id);       	
        }        
        return mapLeads; 
	}
	
	global PageReference createCarFromLead(){
		Lead oLead= new Lead();
		RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        res.addHeader('Content-Type', 'application/json');
        String leadID = req.params.get('leadId');
        if(leadId != null){
        	LeadsController.createCar(oLead);
        }
        PageReference pr = new PageReference('/apex/getLeads');
	    pr.setRedirect(true);    
	    return pr;
	}
	
	global Map<String, String> getCars(){
        String jSONLeadsCar = '';
        Map<String, String> mapLeads = new Map<String, String>();
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('','Select Car'));
        if(oLead.Id !=null){
        	String query ='Select Id, price__c, Name, fullName__c from Car__c where Lead__c = \'' + oLead.Id  +'\'';   	
			List<Car__c> searchWithLead = Database.query(query);
			if(searchWithLead.size() >0){
				jSONLeadsCar= JSON.serialize(searchWithLead);
				List<Car__c> result = (List<Car__c>)JSON.deserialize(jSonLeadsCar, List<Car__c>.class);
		        for(Car__c oCar: result){
		        	options.add(new SelectOption(oCar.Name, oCar.Name));
		        	mapLeads.put(oCar.Name, oCar.Name);        	
		        }			
			}else{
				mapLeads.put('No hay registros relacionados', '');			
			}
        }else{
        	mapLeads.put('No hay registros relacionados', '');       	
        }        
        return mapLeads;	
	}
	
	public static void createCar(Lead oLead){
		try{
			List<Lead> oListLead = [select Name, Id from Lead where Id =: oLead.Id];
			if(oListLead.size() >0){
				Car__c oCarc= new Car__c();
				insert oCarc;				
			}
		} catch (Exception ex) {
            system.debug(ex.getMessage());
        }
	}
	
	@future(callout=true)
	public static void consumeApi() {
		String laborRate = '';
		String zipCode = '';
		String apiKey = 'Ow8VcQTZTCWFsQYAUOjz';
		String requestEndpoint = 'https://agsdev-ags.cs10.force.com/services/apexrest/v1/carsApi';
		requestEndpoint += '?zipcode=' + zipCode;
		requestEndpoint += '&APPID=' + apiKey;		
		Http http = new Http();
		HttpRequest request = new HttpRequest();
		request.setEndpoint(requestEndpoint);
		request.setMethod('GET');
		HttpResponse response = http.send(request);
		if(response.getStatusCode() == 200){
    		Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
		   	laborRate = String.valueOf(results.get('laborRate'));	
		} else {
			ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Error in the service. Please Try Again');
           	ApexPages.addMessage(myMsg);
		}
	}	
}