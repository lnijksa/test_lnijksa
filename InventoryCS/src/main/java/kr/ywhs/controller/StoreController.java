package kr.ywhs.controller;

import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import kr.ywhs.dao.InventoryVO;
import kr.ywhs.service.StoreService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class StoreController {
	
	@Autowired
	StoreService storeservice;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String mainView(Locale locale, Model model) {
		return "bookMarkList";
	}
	@RequestMapping(value = "/bookMarkList2", method = RequestMethod.GET)
	public String mainView2(Locale locale, Model model) {
		return "bookMarkList2";
	}
	
	@RequestMapping(value = "/bookMarkList", method = RequestMethod.GET)
	public String viewBookMark(Model model) {
		return "bookMarkList";
	}
	
	@RequestMapping(value = "/nearStoreMapSS", method = RequestMethod.GET)
	public String viewNearStoreMapSS(Model model) {
		return "nearStoreMapSS";
	}
	
	@RequestMapping(value = "/searchStoreSS", method = RequestMethod.GET)
	public String viewSearchStore(Model model) {
		return "searchStoreSS";
	}
	
	@RequestMapping(value = "/printStoreInfoSS", method = RequestMethod.GET)
	public String viewPrintStoreInfoSS(Model model) {
		return "printStoreInfoSS";
	}

	@RequestMapping(value = "/printStoreInfoSS", method = RequestMethod.POST)
	public String searchStoreAction(Model model, HttpServletRequest request) {
		String url="";
		String storeName = (String)request.getSession().getAttribute("storeName");
		String productName= request.getParameter("productName");
		Map<String,Object> paramMap = new HashMap<String, Object>();
		paramMap.put("storeName", storeName);
		paramMap.put("productName", productName);
		List<InventoryVO> resultList = (List<InventoryVO>) storeservice.searchStoreSS(paramMap);
		request.getSession().setAttribute("result", resultList);
		url="resultStoreSS";
		if(resultList.size()==0)
		{
			url = "redirect:/errorSS";
		}
		return url;
	}
	
	@RequestMapping(value = "/resultStoreSS", method = RequestMethod.GET)
	public String viewResultStoreSS(Model model) {
		return "resultStoreSS";
	}
	
	@RequestMapping(value = "/addBookMark", method = RequestMethod.GET)
	   public String addBookMarkAction(Model model, HttpServletRequest request) {
	      return "addBookMark";
	   }
	   
	   @RequestMapping(value = "/deleteBookMark", method = RequestMethod.GET)
	   public String deleteBookMarkAction(Model model, HttpServletRequest request) {
	      return "deleteBookMark";
	   }

}
