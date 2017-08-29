package com.ebergstein.store.services;

import java.util.List;

import org.springframework.stereotype.Service;

import com.ebergstein.store.models.Product;
import com.ebergstein.store.repositories.ProductRepository;

@Service
public class ProductService {
	
	private ProductRepository productRepository;
	
	public ProductService(ProductRepository productRepository){
		this.productRepository = productRepository;
	}
	
	public List<Product> findAll(){
		return (List<Product>) productRepository.findAll();
	}
	
	public Product save(Product product){
		return productRepository.save(product);
	}
	
	public Product find(Long id){
		return(Product) productRepository.findOne(id);
	}
	
	public void delete(Long id){
		productRepository.delete(id);
	}

}
