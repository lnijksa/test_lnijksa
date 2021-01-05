package kr.ywhs.dao;

public class InventoryVO {
	String store_name;
	String product_name;
	String amount;


	public InventoryVO(String store_name, String product_name, String amount) {
		this.store_name = store_name;
		this.product_name = product_name;
		this.amount = amount;
	}

	public InventoryVO(){}


	public String getStore_name() {
		return store_name;
	}


	public void setStore_name(String store_name) {
		this.store_name = store_name;
	}


	public String getProduct_name() {
		return product_name;
	}


	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}


	public String getAmount() {
		return amount;
	}


	public void setAmount(String amount) {
		this.amount = amount;
	}




}
