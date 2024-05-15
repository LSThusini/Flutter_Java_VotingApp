package data;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import Models.Admin;
import Models.Candidate;
import Models.VoteCast;
import Models.Voter;
import acsse.csc03a3.Blockchain;
import acsse.csc03a3.Transaction;

public class Data {
	private List<Voter> voters = new ArrayList<Voter>();
	private List<Candidate> candidates = new ArrayList<Candidate>();
	private List<Voter> votedList = new ArrayList<Voter>();
	private Blockchain<List<VoteCast>> blockChain = new Blockchain<List<VoteCast>>();
	private List<VoteCast> votesBoard = new ArrayList<VoteCast>();
	private List<Admin> adminsList = new ArrayList<Admin>();
	
	private static final String VOTERS_FILE = "src/data/voters.txt";
	private static final String CANDIDATES_FILE = 	"src/data/candidates.txt";
	private static final String ADMIN_FILE = "src/data/admins.txt";
	
	public Data() {
		this.readCandidatesFromFile();
		this.readVotersFromFile();
		this.readAdminsFromFile();
	}
	
	public boolean addTransaction(List<Transaction<List<VoteCast>>> newTrans) {
		if(this.blockChain.isChainValid()) {
			this.blockChain.addBlock(newTrans);
			return true;
		}
		else {
			return false;
		}
		
	}
	
	public List<VoteCast> getVoteCast(){
		return this.votesBoard;
	}
	
	public List<Voter> getVoters() {
		return this.voters;
	}
	
	public List<Admin> getAdmins(){
		return this.adminsList;
	}
	
	public List<Candidate> getCandidates(){
		return this.candidates;
	}
	
	public List<Voter> getVoted(){
		return this.votedList;
	}
	
	private void registerStakes() {
		for(Voter newVoter : voters) {
			this.blockChain.registerStake(newVoter.getFirstName(), 1000);
		}
	}
	
	private void setInitialVotesBoard(List<Candidate> candidatesList) {
		for(Candidate cand : candidatesList) {
			VoteCast newCand = new VoteCast(cand.getId(), 0);
			this.votesBoard.add(newCand);
		}
	}
	
	public boolean castVote(int candId, Voter voter) {
		
		boolean isCasted = false;
		if(blockChain.isChainValid()) {
			for(VoteCast cand : votesBoard) {
				if(cand.getId() == candId) {
					cand.setVote(cand.getVote() + 1);
				}
			}
		}
		Transaction<List<VoteCast>> newTransation = new Transaction<List<VoteCast>>(voter.getIdNum(),String.valueOf(candId), votesBoard);
		List<Transaction<List<VoteCast>>> transactionsList = new ArrayList<Transaction<List<VoteCast>>>();
		transactionsList.add(newTransation);
		isCasted = addTransaction(transactionsList);
		if(isCasted) {
			this.votedList.add(voter);
		}
		//Testing if the transaction was added successfully.
		System.out.println(this.blockChain.toString());
		
		return isCasted;
	}
	
	/**
	 * Read voters and store them in the voters list.
	 *
	 */
	private void readVotersFromFile() {
		try (BufferedReader br = new BufferedReader(new FileReader(VOTERS_FILE))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] parts = line.split("#");
                if (parts.length == 3) {
                    String idNum = parts[0];
                    String surname = parts[1];
                    String firstName = parts[2];
                    Voter voter = new Voter(idNum, surname, firstName);
                    voters.add(voter);
                } else {
                    System.err.println("Invalid format in line: " + line);
                }
               
            }
            this.registerStakes();
        } catch (IOException e) {
            System.err.println("Error reading voters file: " + e.getMessage());
        }
	}
	
	private void readAdminsFromFile() {
		try(BufferedReader br = new BufferedReader(new FileReader(ADMIN_FILE))){
			String line;
			while((line = br.readLine()) != null) {
				String[] parts = line.split("#");
				String id = parts[0];
				String name = parts[1];
				String surname = parts[2];
				
				Admin newAdmin = new Admin(id, name, surname);
				this.adminsList.add(newAdmin);
				
			}
		}catch(IOException e) {
			System.err.println("Error occured while reading Admins");
		}
	}
	
	/**
	 * Read candidates and store them in the candidates list.
	 */
	private void readCandidatesFromFile() {
		try(BufferedReader br = new BufferedReader(new FileReader(CANDIDATES_FILE))){
			String line;
			while((line = br.readLine()) != null) {
				 String[] parts = line.split("#");
				 int id = Integer.parseInt(parts[0]);
				 String Surname = parts[1];
				 String firstName = parts[2];
				 String partyName = parts[3];
				 String partyAbbrev = parts[4];
				 String candImage = parts[5];
				 String partyImage = parts[6];
				 
				 Candidate newCand = new Candidate(id, Surname, firstName, partyName, partyAbbrev, candImage, partyImage);
				 candidates.add(newCand);
			}
			this.setInitialVotesBoard(candidates);
		}
		catch(IOException e) {
			System.err.println("Error reading candidates file : " + e.getMessage());
		}
	}

}
