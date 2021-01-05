package kr.ywhs.controller;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;
import java.util.Enumeration;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import kr.ywhs.dao.InventoryVO;
import kr.ywhs.service.ProductService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class ProductController {
   @Autowired
   ProductService productService;


   @RequestMapping(value = "/searchProductPS", method = RequestMethod.GET)
   public String viewSearchProductPS(Model model) {
      return "searchProductPS";
   }

   @RequestMapping(value = "/searchProductPS", method = RequestMethod.POST)
   public String viewResultProductPS(Model model,HttpServletRequest request) {
      String url = "";
      HttpSession session=request.getSession(true);
      String productName=request.getParameter("productSerch");
      String address=request.getParameter("address");
      Map<String,Object> m=new HashMap<String, Object>();
      m.put("productName", productName);
      m.put("address", address);
      try {
		productName= URLEncoder.encode(productName,"UTF-8");
		address=URLEncoder.encode(address,"UTF-8");
	} catch (UnsupportedEncodingException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}

      ArrayList m1=productService.searchProductPS(m);
      url="resultProductPS";
      if(m1.size()==0)
      {
         url = "redirect:/errorPS";         
      }
      session.setAttribute("result", m1);
      return url;
   }

   @RequestMapping(value = "/printStoreInfoPS", method = RequestMethod.GET)
   public String viewPrintStoreInfoPS(Model model) {
      return "printStoreInfoPS";
   }

   @RequestMapping(value = "/moreMain", method = RequestMethod.GET)
   public String viewMoreMain(Model model) {
      return "moreMain";
   }

   @RequestMapping(value = "/moreNotice", method = RequestMethod.GET)
   public String viewMoreNotice(Model model) {
      return "moreNotice";
   }

   @RequestMapping(value = "/moreVersion", method = RequestMethod.GET)
   public String viewMoreVersionn(Model model) {
      return "moreVersion";
   }
   
   @RequestMapping(value = "/moreMadeBy", method = RequestMethod.GET)
   public String viewMoreMadeBy(Model model)
   {
      return "moreMadeBy";
   }
}