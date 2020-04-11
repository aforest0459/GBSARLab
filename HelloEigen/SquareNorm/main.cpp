#include "../Common/common.h"

using namespace Eigen;
using namespace std;

int main()
{
	RowVectorXd m_point1(1,3),m_point2(1, 3), m_length(1, 3);
	m_point1 << 7.044, -6.996, -0.140;
	m_point2 << 5.963, -7.264, -0.148;
	m_length = (m_point1 - m_point2).transpose();
	cout << "SquareNorm:\n" << m_length.transpose().squaredNorm() << endl;

	return 0;
}
