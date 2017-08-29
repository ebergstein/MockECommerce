package com.ebergstein.store.repositories;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.ebergstein.store.models.Product;

@Repository
public interface ProductRepository extends CrudRepository<Product, Long>{
}
