package hr.dao.test;

import java.util.List;

import hr.dao.EmployeeDao;
import hr.vo.EmployeeVo;

public class EmployeeDaoTest {

	public static void main(String[] args) {
		testFindByNameTest("mahe");
		testFindBySalary(10000, 20000);
	}

	private static void testFindBySalary(int min, int max) {
		List<EmployeeVo> list = new EmployeeDao().findBySalary(min, max);
		for (EmployeeVo vo : list) {
			System.out.println(vo);
		}
	}

	public static void testFindByNameTest(String keyword) {
		List<EmployeeVo> list = new EmployeeDao().findByName(keyword);
		for (EmployeeVo vo : list) {
			System.out.println(vo);
		}
	}
}
