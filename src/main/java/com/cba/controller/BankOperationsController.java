package com.cba.controller;



import com.cba.bean.Deposit;
import com.cba.service.AccountServiceImpl;
import com.cba.service.DepositServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
public class BankOperationsController {

//    @Autowired
    public static AccountServiceImpl accountServiceImpl;
    public static DepositServiceImpl depositServiceImpl;
    
    
	@RequestMapping(value="/operations", method=RequestMethod.GET)
	public String test() {
		return "operations";
		}
		
	
	@RequestMapping(value="/deposit",method=RequestMethod.GET)
	@ResponseBody
	public String showDeposit() {
		return "";
	}
	
	@RequestMapping(value="/getAccountSummary",method=RequestMethod.GET)
	@ResponseBody
	public String getAccountSummary(@RequestParam("accountNumber") String accountNumber) {
            accountServiceImpl=new AccountServiceImpl();
        return accountServiceImpl.getAccountSummary(accountNumber);
    }
        
        
        @RequestMapping(value="/deposit",method=RequestMethod.POST)
        @ResponseBody 
	public String doDeposit(@RequestBody Deposit deposit){
            depositServiceImpl=new DepositServiceImpl();
        return depositServiceImpl.doDeposit(deposit);
	}
		
        

}
