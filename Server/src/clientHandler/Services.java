package clientHandler;

public interface Services {

	void sendResponse(String message);
	void getRequest();
	boolean AuthenticateVoter(String idNum);	
	boolean castVote(int candId);
}
