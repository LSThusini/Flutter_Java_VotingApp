package Models;

public class VoteCast {
	
	private int id;
	private int vote;
	
	public VoteCast(int id, int vote) {
		this.id = id;
		this.vote = vote;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getVote() {
		return vote;
	}

	public void setVote(int vote) {
		this.vote = vote;
	}
	
	

}
