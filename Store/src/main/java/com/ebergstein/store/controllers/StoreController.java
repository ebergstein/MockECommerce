package com.ebergstein.store.controllers;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.IdentityHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ebergstein.store.models.Product;
import com.ebergstein.store.services.ProductService;

@Controller
public class StoreController {
	
	private ProductService productService;
	private Map<Long, Integer> cart;
	//private List<Long> ids;
	
	public StoreController(ProductService productService){
		this.productService = productService;
		this.cart = new IdentityHashMap<>();
		//this.ids = new ArrayList<>();
	}
	
	@RequestMapping("/")
	public String home(Model model, @ModelAttribute("product") Product product){
		List<Product> products = productService.findAll();
		model.addAttribute("products", products);
		return "index.jsp";
	}
	
	@RequestMapping("/checkout")
	public String cart(Model model, @ModelAttribute("product") Product product){
		List<Product> products = new ArrayList<>();
		List<Long> ids = new ArrayList<>(cart.keySet());
		for(int i = 0; i < ids.size(); i++){
			Product temp = productService.find(ids.get(i));
			if(products.contains(temp) == false){
				products.add(temp);
			}
		}
		model.addAttribute("products", products);
		model.addAttribute("cart", cart);
		Float total = (float) 0.00;
		for(int i = 0; i < products.size(); i++){
			for(int j = 0; j < cart.get(products.get(i).getId()); j++){
				total += products.get(i).getPrice();
			}
		}
		model.addAttribute("total", total);
		return "cart.jsp";
	}
	
	@RequestMapping("/add/{id}")
	public String add(@PathVariable("id") Long id){
		Product product = productService.find(id);
		if(product != null){
			if(cart.containsKey(id)){
			//if(ids.contains(id)){
				cart.put(id, cart.get(id) + 1);
			}
			else{
				cart.put(id, 1);
				//ids.add(id);
			}
		}
		return "redirect:/";
	}
	
	@RequestMapping("/delete/{id}")
	public String delete(@PathVariable("id") Long id){
		Product product = productService.find(id);
		if(product != null){
			if(cart.containsKey(id)){
			//if(ids.contains(id)){
				if(cart.get(id) > 1){
					cart.put(id, cart.get(id) - 1);
				}
				else{
					cart.remove(id);
					//ids.remove(id);
				}
			}
		}
		return "redirect:/checkout";
	}
	
	@RequestMapping("/delete")
	public String clear(){
		cart.clear();
		//ids.clear();
		return "redirect:/";
	}
	
	@PostMapping("/addproduct")
	public String addProduct(@RequestParam(value = "name") String name, 
			@RequestParam(value = "description") String description, @RequestParam(value = "price") Float price){
		Product product = new Product(name, description, price);
		productService.save(product);
		return "redirect:/";
	}
}
