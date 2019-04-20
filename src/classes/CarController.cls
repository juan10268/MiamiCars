global class CarController {
	public Car__c oCar {get;set;}
	
	public CarController(){
		oCar = new Car__c();
	}

	public String getName() {
        return 'MyController';
    }
    public Account getAccount() {
        return [select id, name from Account
                 where id = :ApexPages.currentPage().getParameters().get('id')];
    }
    public PageReference saveCar(){
    	if(oCar != null){
    		oCar.fullPrice__c = oCar.price__c + oCar.tax__c;
	    	insert oCar;
    	}
	    PageReference pr = new PageReference('/apex/CarPage');
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
        	options.add(new SelectOption(lead.Name, lead.Id));
        	mapLeads.put(lead.Name, lead.Id);       	
        }        
        return mapLeads; 
	}  
    
    public static List<Car__c> getCars() {
    	List<Car__c> carList = new List<Car__c>();    	
    	carList = [Select price__c, Lead__c, registrationPlate__c, modelYear__c, tax__c, Name, fullPrice__c, leasing__c, downPayment__c, fullName__c from Car__c];    	    	 
    	return carList;
    }
}