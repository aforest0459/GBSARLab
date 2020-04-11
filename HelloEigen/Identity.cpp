#include "../Common/common.h"

using namespace Eigen;
using namespace std;

int main()
{
	
	/*单位矩阵**/
	Matrix<double, Dynamic, Dynamic> m_matrix;
	MatrixXd m_matrix2(3,3);
		
		m_matrix2 << 1,2,3,
			4,5,6,
			7,8,8;
	cout << "MatrixXd::Identity(5, 4):\n"<<MatrixXd::Identity(5, 4) << endl;;
	m_matrix.setIdentity(5, 4);
	cout << "m_matrix.setIdentity(5, 4):\n" << m_matrix << endl;

	/*求逆矩阵需要先判断是否可逆**/
	
	cout << "m_matrix2.inverse（）:\n" << m_matrix2.inverse() << endl;

	/*逐元素取倒数**/
	cout << "m_matrix.array().inverse():\n" << m_matrix.array().inverse() << endl;
	cout << "m_matrix.cwiseInverse():\n" << m_matrix.cwiseInverse() << endl;

	return 0;
}
