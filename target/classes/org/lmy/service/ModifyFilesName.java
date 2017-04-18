package org.lmy.service;

import java.io.File;

/**
 * Created by mike on 2017/3/17.
 */
public class ModifyFilesName {
	private static void println(Object obj) {
		System.out.println(obj);
	}

	public static void main(String[] args) throws Exception {
		String dirPath = "D:\\Test\\jpgs";
		String strJPG = ".jpg";

		File dir = new File(dirPath);
		File[] files = dir.listFiles();
		for (File f : files) {
			String fileName = f.getName();
			String newFileName = fileName + strJPG;
			f.renameTo(new File(dirPath + "\\" + newFileName));
		}

	}
}
