package Models;

public class Voter {

	private String idNum;
	private String Surname;
	private String firstName;
	
	public Voter(String idNum, String surname, String firstName) {
		this.idNum = idNum;
		this.Surname = surname;
		this.firstName = firstName;
	}
	
	public String getIdNum() {
		return idNum;
	}

	public void setIdNum(String idNum) {
		this.idNum = idNum;
	}

	public String getSurname() {
		return Surname;
	}

	public void setSurname(String surname) {
		Surname = surname;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
}

