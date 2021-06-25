package util.db;

public class StringUtil {
	public static String nvl(String str, String repl) {
		if (nvl(str).equals("")) {
			return repl;
		}
		return str;
	}

	public static String nvl(String str) {
		if (str == null || str.trim().equals("")) {
			return "";
		}
		return str;
	}
}
