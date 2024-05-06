package Models;

public class Candidate {
	
	private int Id;
	private String Surname;
	private String firstName;
	private String partyName;
	private String partyAbbrev;
	private String candImage;
	private String partyImage;
	
	public Candidate(int id, String surname, String firstName, String partyName, String partyAbbrev, String candImage,
			String partyImage) {
		
		this.Id = id;
		this.Surname = surname;
		this.firstName = firstName;
		this.partyName = partyName;
		this.partyAbbrev = partyAbbrev;
		this.candImage = candImage;
		this.partyImage = partyImage;
	}
	
	
	public int getId() {
		return Id;
	}
	public void setId(int id) {
		Id = id;
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
	public String getPartyName() {
		return partyName;
	}
	public void setPartyName(String partyName) {
		this.partyName = partyName;
	}
	public String getPartyAbbrev() {
		return partyAbbrev;
	}
	public void setPartyAbbrev(String partyAbbrev) {
		this.partyAbbrev = partyAbbrev;
	}
	public String getCandImage() {
		return candImage;
	}
	public void setCandImage(String candImage) {
		this.candImage = candImage;
	}
	public String getPartyImage() {
		return partyImage;
	}
	public void setPartyImage(String partyImage) {
		this.partyImage = partyImage;
	}
	
	
	

}
