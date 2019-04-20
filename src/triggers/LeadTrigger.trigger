trigger LeadTrigger on Lead (before insert, before update) {
	List<Lead> addLead = new List<Lead>();
	for(Lead oLead :trigger.new){
		LeadsController.consumeApi();
		Lead lead = new Lead();
		lead.firstname=oLead.firstname;	
		lead.lastname=oLead.lastname;	
	    lead.company=oLead.company;	
	   	lead.phone=oLead.phone;	
	    lead.email=oLead.email;	
	    lead.fax=oLead.fax;	
	    lead.status=oLead.status;
	    lead.description = oLead.description;   
    	addLead.add(lead);
	}
}