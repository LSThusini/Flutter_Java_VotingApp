package data;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import Models.Candidate;
import Models.Voter;

public class Data {
	private List<Voter> voters = new ArrayList<Voter>();
	private List<Candidate> candidates = new ArrayList<Candidate>();
	private List<Voter> votedList = new ArrayList<Voter>();
	
	private static final String VOTERS_FILE = "voters.txt";
	
	public Data() {
		this.readCandidatesFromFile();
		this.readVotersFromFile();
		
	}
	
	public List<Voter> getVoters() {
		return this.voters;
	}
	
	public List<Candidate> getCandidates(){
		return this.candidates;
	}
	
	public List<Voter> getVoted(){
		return this.votedList;
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
        } catch (IOException e) {
            System.err.println("Error reading voters file: " + e.getMessage());
        }
	}
	
	/**
	 * Read candidates and store them in the candidates list.
	 */
	private void readCandidatesFromFile() {
		
	}

}
