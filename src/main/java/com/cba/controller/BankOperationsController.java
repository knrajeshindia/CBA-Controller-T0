package com.cba.controller;



import com.cba.service.AccountServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
public class BankOperationsController {

//    @Autowired
    public static AccountServiceImpl accountServiceImpl;
    
    
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

}
