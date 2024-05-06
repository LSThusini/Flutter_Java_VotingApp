package clientHandler;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;
import java.util.StringTokenizer;

import Models.Voter;
import data.Data;

public class ClientHandler implements Runnable, Services {

	private Socket client = null;
	private BufferedReader reader = null;
	private PrintWriter writer = null;
	private String requestLine = "";
	private Voter voter;
	private Data data;
	
	public ClientHandler(Socket client, Data data) {
		this.client = client;
		this.data = data;
	}

	@Override
	public void run() {
		
		//Voter Logs in
		if(requestLine.startsWith("LOGIN")) {
			
			StringTokenizer tokens = new StringTokenizer(requestLine);
			System.out.println("Login Requested: Command :" + tokens.nextToken());
			String voterID = tokens.nextToken();
			
			if(this.AuthenticateVoter(voterID)) {
				//Voter exists
				this.sendResponse("SUCCESS " + this.voter.getIdNum());
				
			}else {
				//Voter does not exist
				this.sendResponse("FAIL");
			}
		}
	}

	/**
	 * Send
	 */
	@Override
	public void sendResponse(String message) {

		try {
			PrintWriter writer = new PrintWriter(client.getOutputStream(), true);
			writer.println(message);
			writer.flush();
		} catch (IOException e) {
			
			System.err.println("IO exception on sendMessage method");
		}
		
	}

	@Override
	public void getRequest() {
		// TODO Auto-generated method stub
		try {
			//Read the command
			reader = new BufferedReader(new InputStreamReader(client.getInputStream()));
			requestLine = reader.readLine();
			
		} catch (IOException e) {
			
			e.printStackTrace();
		}
		
	}

	@Override
	public boolean AuthenticateVoter(String idNum) {
		boolean isFound = false;
		for(Voter voter : this.data.getVoters()) {
			//Check if voter exists
			if(voter.getIdNum().equals(idNum)) {
				
				//Check id voter has already voted.
				for(Voter v : this.data.getVoted()) {
					if(v.getIdNum().equals(idNum)) {
						return false;
					}
				}
				
				Voter newVoter = new Voter(voter.getIdNum(), voter.getSurname(), voter.getFirstName());
				this.voter = newVoter;
				isFound = true;
			}
		}

		return isFound;
	}

	@Override
	public boolean castVote(String idNum, String candId) {
		// TODO Auto-generated method stub
		return false;
	}
	
}
