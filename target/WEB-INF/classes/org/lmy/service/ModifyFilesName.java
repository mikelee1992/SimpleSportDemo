package org.lmy.service;

import java.io.File;

/**
 * Created by mike on 2017/3/17.
 */
public class ModifyFilesName {
	public static void main(String[] args) throws Exception {
		File dir = new File("D:\\Test\\jpgs");
		File[] files = dir.listFiles();
		for (File f : files) {
			System.out.println(f.getName());
		}
	}
}
