<%@page import="java.sql.*" buffer="8kb" language="java" contentType="text/html; charset=ISO-8859-1" %>
<%
     String name=request.getParameter("t1");
	String email=request.getParameter("t2");
	String age=request.getParameter("t3");
	int no=Integer.parseInt(age);
	String dobString=request.getParameter("t4"); // Rename dob to dobString

	// Parsing dobString into java.sql.Date object
	java.sql.Date dob = java.sql.Date.valueOf(dobString);

	Connection con=null;
	PreparedStatement ps=null;
	String qry=null;
	int result=0;
	try
	{
		Class.forName("oracle.jdbc.driver.OracleDriver");
		con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","system","admin");
		qry="insert into employeees values(?,?,?,?)"; // You are inserting 4 values but you prepared the statement for only 3, corrected.
		ps=con.prepareStatement(qry);
		//set the values
		ps.setString(1,name);
		ps.setString(2,email);
		ps.setInt(3,no); // Assuming age is stored as an int in the database
		ps.setDate(4,dob); // Set date value using setDate() method

		//execute 
		result=ps.executeUpdate();
		if(result==0)
			out.println("Record Not Inserted");
		else
			out.println("Record Inserted");

		ps.close();
		con.close();
	}
	catch(Exception e)
	{
		out.println(e);
	}
	
%>