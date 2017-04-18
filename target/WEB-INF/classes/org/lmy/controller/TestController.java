package org.lmy.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;

/**
 * Created by mike on 2017/3/6.
 */
@Controller
@RequestMapping(value = "/testController")
public class TestController {

	private void closePrintWriter(PrintWriter writer) {
		try {
			if (null != writer) {
				writer.flush();
				writer.close();
				writer = null;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@RequestMapping(value = "/test1")
	public String test1(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return "test1.jsp";
	}
}
