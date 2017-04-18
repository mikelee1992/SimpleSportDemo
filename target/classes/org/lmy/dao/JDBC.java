package org.lmy.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 * Created by mike on 2017/3/5.
 */
public class JDBC {
	public static void main(String[] args) throws Exception {
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection(
				"jdbc:mysql://127.0.0.1:3306/babasport12?" +
						"useUnicode=true&characterEncoding=utf8&autoReconnect=true&failOverReadOnly=false",
				"root",
				"123");
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery("select * from test_tb where 1=1");
		while (rs.next()) {
			String id = rs.getString("id");
			String name = rs.getString("name");
			String birthday = rs.getString("birthday");
			System.out.print("ID:" + id + ", name:" + name + ", birthday:" + birthday);
		}

	}
}
