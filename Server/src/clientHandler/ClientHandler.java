package clientHandler;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;
import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;

import Models.Admin;
import Models.VoteCast;
import Models.Voter;
import acsse.csc03a3.Transaction;
import data.Data;

public class ClientHandler implements Runnable, Services {

	private Socket client = null;
	private BufferedReader reader = null;
	private String requestLine = "";
	private Voter voter;
	private Data data;
	private Admin admin;
	private int VoterOrAdmin = 0;
	
	private boolean processing;
	
	public ClientHandler(Socket client, Data data) {
		this.client = client;
		this.data = data;
	}

	@Override
	public void run() {
		
		
		System.out.println("Start Processing Commands");
		processing = true;
		while(processing) {
			
				getRequest();
				
				StringTokenizer tokens = new StringTokenizer(requestLine);
				
				if(requestLine.startsWith("LOGIN")) {
					
					String command =tokens.nextToken(); 
					String voterID = tokens.nextToken();
					
					if(this.AuthenticateVoter(voterID)) {
						//User exists and is an admin
						if(this.admin != null && this.VoterOrAdmin == 2) {
							this.sendResponse("ADMIN " + this.admin.getId());
						}
						if(this.voter != null && this.VoterOrAdmin == 1) { //User is a voter
							this.sendResponse("VOTER " + this.voter.getIdNum());
						}
						
						
					}else {
						//Voter does not exist
						this.sendResponse("FAIL");
					}
				}else if(requestLine.startsWith("VOTE")) {
					//Handle the cast by getting the id of the candidate being voted for
					//The voter will be the person logged in.
					String command =tokens.nextToken();
					
					if(this.castVote(Integer.parseInt(tokens.nextToken()))) {
						this.sendResponse("VOTE_SUCCESS");
					}else {
						this.sendResponse("VOTE_FAIL");
					}
					
				}
				else if(requestLine.startsWith("RESULTS")) {
					//Send the results to the client application.
					String command =tokens.nextToken();
					this.sendResponse(this.getResults());
				}
		}
		
	}
	
	
	
	
	private String getResults() {
		StringBuilder votesResults = new StringBuilder();
		for(VoteCast cand : data.getVoteCast()) {
			votesResults.append(cand.getVote() + "#" + cand.getId()).append("\n");
		}
		
		return votesResults.toString();
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
			System.out.println(requestLine);
			
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
				this.VoterOrAdmin = 1;
			}
		}
		
		//Check the user is the admin
		for(Admin ad : this.data.getAdmins()) {
			if(ad.getId().equals(idNum)) {
				this.admin = new Admin(ad.getId(),ad.getName(),ad.getSurname());
				isFound = true;
				this.VoterOrAdmin = 2;
			}
		}

		return isFound;
	}

	@Override
	public boolean castVote(int candId) {
		for(Voter v : this.data.getVoted()) {
			if(v.getIdNum().equals(this.voter.getIdNum())) {
				return false;
			}
		}
		return data.castVote(candId, this.voter);
	}
	
}
