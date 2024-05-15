package Models;

public class Admin {
	
	private String Id;
	private String name;
	private String Surname;
	
	public Admin(String id, String name, String surname) {
		this.Id = id;
		this.name = name;
		this.Surname = surname;
		
	}

	public String getId() {
		return Id;
	}

	public void setId(String id) {
		Id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getSurname() {
		return Surname;
	}

	public void setSurname(String surname) {
		Surname = surname;
	}
	
	

}
