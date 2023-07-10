package bookshop.main;

import java.util.List;
import java.util.Scanner;

import bookshop.dao.BookDao;
import bookshop.vo.BookVo;

public class BookShop {

	public static void main(String[] args) {
		System.out.println("*****도서 정보 출력하기******");
		displayBookInfo();

		Scanner scanner = new Scanner(System.in);
		System.out.print("대여 하고 싶은 책의 번호를 입력하세요:");
		int num = scanner.nextInt();
		scanner.close();

		BookVo vo = new BookVo();
		vo.setNo((long)num);
		vo.setRent("y");
		new BookDao().updateRent(vo);

		System.out.println("*****도서 정보 출력하기******");
		displayBookInfo();
	}
	
	public static void displayBookInfo() {
		List<BookVo> list = new BookDao().findAll();
		
		for (BookVo vo : list) {
			System.out.printf("책 제목: %s, 작가: %s, 대여 유무: %s\n", vo.getTitle(), vo.getAuthorName(), ("y".equals(vo.getRent()) ? "대여 중" : "재고 있음"));
		}
	}
}