package connection;

import java.io.IOException;
import java.net.ServerSocket;
import java.util.ArrayList;
import java.util.List;

import Models.Candidate;
import Models.Voter;
import clientHandler.ClientHandler;
import data.Data;

public class Server {


	private static boolean isRunning = false;
	private static ServerSocket server;
	private static final int PORT = 9999;
	private Data data;
	
	/**
	 * Constructor which assigns the Server to a port
	 */
	public Server() {
		this.data = new Data();
		try {
			server = new ServerSocket(PORT);
			System.out.println("Server waiting on port: " + server.getLocalPort());
			isRunning= true;
			
			
		} catch (IOException e) {
			
			System.err.println("Error connecting the server");
		}
		
	}
	
	
	
	/**
	 * Helper method to start server and create threads for each incoming client
	 */
	private void startServer() {
		while(isRunning == true) {
			try {
				ClientHandler client1 = new ClientHandler(server.accept(), this.data);
				Thread newthread = new Thread(client1);
				newthread.start();
				System.out.println("New Client");
			}catch(IOException e) {
				e.printStackTrace();
			}
		}
	}
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		
		Server server = new Server();
		server.startServer();

	}
}
