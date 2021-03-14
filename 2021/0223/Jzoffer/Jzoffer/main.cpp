//
//  main.cpp
//  Jzoffer
//
//  Created by Augus on 2021/2/23.
//

#include <iostream>
#include <cmath>
using namespace std;

struct ListNode {
    int val;
    struct ListNode *next;
    ListNode(int x) { val = x; }
};



class Solution {
public:
    /// 获取单链表的中点
    ListNode *getIntersectionNode(ListNode *headA, ListNode *headB) {
        
        if (headA == NULL || headB == NULL) {
            return NULL;
        }
        
        ListNode *node1 = headA;
        ListNode *node2 = headB;
        
        while (node1 != node2) {
            node1 = node1 != NULL ? node1->next : headB;
            node2 = node2 != NULL ? node2->next : headA;
        }
        return node1;
    }
    
    /// 斐波那契数列 递归法
    int Fib(int n) {
        if (n == 0) {
            return 0;
        }else if (n == 1){
            return 1;
        }else {
            return Fib(n-1) + Fib(n - 2);
        }
    }
    /// 斐波那契数列 迭代法
    int Fib1(int n) {
        int nums[2] = {0,1};
        if (n < 2) {
            return nums[n];
        }
        
        int i = 1;
        int fib1 = 0,fib2 = 1, fib = 0;
        while (i < n) {
            fib = fib1 + fib2;
            fib1 = fib2;
            fib2 = fib;
            i++;
        }
        return fib;
    }
    
    /// big heap sort
    void maxHeapify(int nums[], int i,int len) {
        for (; (i << 1) + 1 < len; ) {
            int lson = (i << 1) + 1;
            int rson = (i << 1) + 2;
            int large;
            if (lson <= len && nums[lson] > nums[i]) {
                large = lson;
            } else {
                large = i;
            }
            if (rson <= len && nums[rson] > nums[large]) {
                large = rson;
            }
            if (large != i) {
                std::swap(nums[i],nums[large]);
            } else {
                break;
            }
        }
    }
    // creat big heap
    void buildMaxHeap(int nums[],int len) {
        for (int i = len / 2; i >= 0; i--) {
            maxHeapify(nums, i, len);
        }
    }
    
    // 进行大顶堆排序
    void heapSort(int nums[],int len) {
        // 创建堆
        buildMaxHeap(nums, len);
        // 首先把数组首元素和尾元素对换，长度-1
        // 把长度-1剩下的数组进行大顶堆排序
        // 循环
        for (int i = len; i>= 1; --i) {
            std::swap(nums[i],nums[0]);
            len -= 1;
            maxHeapify(nums, 0, len);
        }
    }
    
    /********************** ************************/
    
    /// 寻找旋转数组的最小值
    int findMin(int nums[],int len) {
        if (len <= 0) {
            return 0;
        }
        int left = 0,right = len - 1;
        if (nums[right] > nums[0]) {
            return nums[0];
        }
        
        while (right >= left) {
            int mid = left + (right - left) / 2;
            if (nums[mid] > nums[mid + 1]) {
                return nums[mid + 1];
            }
            
            if (nums[mid - 1] > nums[mid]) {
                return nums[mid];
            }
            
            if (nums[mid] > nums[0]) {
                left = mid + 1;
            }else {
                right = mid - 1;
            }
        }
        
        return -1;
    }
    
    /// 判断在一个矩阵中是否存在一条包含某字符串所有字符的路径，（走过的点不能再次走）
    bool exist(int nums[],const char *str) {
//        int row = nums.size();
//        int row = 6;
//        int col = num[0].size();
//        int col = 5;
        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                if (true) {
                    
                }
            }
        }
        
        return false;
    }
    int rows,cols;
    bool dfs(int nums[],const char *str,int i,int j,int k) {
        // 检查下标的合法
        if (i >= rows || i < 0 || j >= cols || j < 0 ) return  false;
        
//        if (k == ) {
//            <#statements#>
//        }
        
        return false;
    }
    
    
    
    /// 统计二进制中的1的个数
    int oneCount(int a) {
        int res = 0;
        while (a) {
            res += a & 1;
            a >>= 1;
            std::cout << a << "\n";

            
        }
        return res;
    }
    
    /// 数值的整数次方
    int myPow(int x,int n) {
        if (x == 0) return 0;
        float res = 1;
        if (n < 0) {
            x = 1 / x;
            n = -n;
        }
        
        while (n) {
            if (n & 1) {
                res *= x;
            }
            x *= x;
            n >>= 1;
        }

        return res;
    }
    
    /// 打印从1到最大的n位数的列表
    
    int * printArray(int n) {
        static int num[] = {};
        for (int i = 1; i < myPow(10, n); i++) {
            num[i] = i;
        }
        return num;
        
    }
    
    /// 删除链表节点(双指针)
    
    ListNode * delNode(ListNode *head,int val) {
    
        //边界条件判断
        if (head == NULL) {
            return head;
        }
        // 如果要删除的是头节点 那么
        if (head->val == val) {
            return head->next;
        }
        
        
        ListNode *cur = head;
        while (cur->next != NULL && cur->next->val != val) {
            cur = cur->next;
        }
        // 删除节点
        cur->next = cur->next->next;
        return head;
    }
    
    /// 给定一组非负整数 nums，重新排列它们每个数字的顺序（每个数字不可拆分）使之组成一个最大的整数。
    
    const char * largest(int nums[],int len) {
     
        const char * null = NULL;
        // number to string
        for (int i = 0; i < len; i++) {
//            nums[i] = String.valueOf(nums[i]);
            
        }
//        nums.sort
        // 排序 并判断 n1n2 > n2n1
        
        // 判断临界值
//        if (nums[0] == `\0`) {
//            return "0";
//        }
        
        // 返回字符串
        
        return null;
        
    }
    
    
    /// LCS =====>DP
    /// 构建c[i][j]需要O(mn)，输出1个LCS的序列需要O(m+n)
    int lcs(string s1, string s2) {
        
        int n = (int)s1.length();
        int m = (int)s2.length();
        
        // 创建二维数组
        int **c = new int*[n];
        for (int i = 0; i < n; i++) {
            c[i] = new int(m);
        }
        
        
        // 递归填表
        for (int i = 0; i <= n; i++) {
            for (int j = 0; j <= m; j++) {
                if (i == 0 || j == 0) {
                    c[i][j] = 0;
                } else if(s1[i-1] == s2[j-1]) {
                    c[i][j] = c[i-1][j-1] + 1;
                } else {
//                    c[i][j] = max_element(c[i-1][j], c[i][j-1]);
                }
            }
        }
        
        
        // 释放二维数组
        for (int i = 0; i < n; i++) {
            delete []c[i];
        }
        delete []c;
        return c[n][m];
    }
    
    // 翻转链表
//    ListNode*  reverseList1(ListNode *head) {
//        if (head == NULL) {
//            return NULL;
//        }
//
//        ListNode *curr = head;
//        ListNode *pre = NULL,*tmp = NULL;
//        while (curr) {
//            tmp = curr->next;
//            curr->next = pre;
//            pre = curr;
//            curr = tmp;
//        }
//
//        return pre;
//    }
    
    // DP寻找最大子序列 或者子串
    int lcs1 (string s1,string s2) {
        
        int len1 = (int)s1.size();
        int len2 = (int)s2.size();
        
        // 初始化二维数组
        int **c = new int*[len1];
        for (int i = 0; i < len1; i++) {
            c[i] = new int[len2];
        }
        
        for (int i = 0; i < len1; i++) {
            for (int j = 0; j < len2; j++) {
                if (i == 0 || j == 0) {
                    c[i][j] = 0;
                } else if(s1[i-1] == s2[j-1]){
                    c[i][j] = c[i-1][j-1] + 1;
                } else {
//                    c[i][j] = max_element(c[i-1][j], c[i][j-1]);
                }
            }
        }
        
        // 返回数组
        while (len1 > 0 && len2 > 0) {
            
        }
        
        
        // 释放二维数组
        for (int i = 0; i < len1; i++) {
            delete []c[i];
        }
        delete []c;
        return c[len1][len2];
    }
    
    // 两个子串的最长子序列长度
    int findSubLen(string s1,string s2) {
        // get bound len
        int len1 = (int)s1.size();
        int len2 = (int)s2.size();
        // init two array
        int **c = new int*[len1];
        for (int i = 0; i < len1; i++) {
            c[i] = new int[len2];
        }
        
        
        // main judge
        
        for (int i = 0; i < len1; i++) {
            for (int j = 0; j < len2; j++) {
                if (s1[i] == 0 || s2[j] == 0) {
                    c[i][j] = 0;
                }else if(s1[i-1] == s2[j-1]) {
                    c[i][j] = c[i-1][j-1] + 1;
                } else {
//                    c[i][j] = max_element(c[i-1][j], c[i][j-1]);
                }
            }
        }
        
        
        // del two array
        for (int i = 0; i < len1; i++) {
            delete []c[i];
        }
        delete []c;
        
        return c[len1][len2];
    }
    
    
    
};


void testPoint() {
    
    int a = 5;
//    int *p1 = &a;
//    std::cout << p1 << "\n";
    
//    int b = 8;
//    p1 = &b;// 指针修改
//    std::cout << p1 << "\n";
//
//    b = 10;
//    std::cout << p1 << "\n";


    
    const int *p2 = &a;
    std::cout << p2 << "\n";
    
    a = 10;
    std::cout << a << "\n";
    
    int c = 100;
    p2 = &c;
    std::cout << p2 << "\n";

    
    
    const int * const p3 = &a;
    std::cout << p3 << "\n";
    
//    p3 = &c;
    std::cout << p3 << "\n";
}

/// 指针函数与函数指针
int* addition(int a,int b) {
    int *sum = new int(a+b);
    return sum;
}

int subtraction(int a,int b) {
    return a-b;
}

int operation(int x,int y,int (*func)(int,int)) {
    return (*func)(x,y);
}

int (*minus)(int,int) = subtraction;


int main(int argc, const char * argv[]) {
    // insert code here...
    std::cout << "Hello, World!\n";
    

    Solution sol;
    
    int *m = addition(5, 6);
    std::cout << *m << "\n";
    
//    int n = operation(3, *m, minus<>);
    
    
    
//    cout <<"The fib res is " << sol.Fib(10) << endl;
//    std::cout << sol.Fib1(3);
//    int num[] = {4,5,6,7,1,2};
//    int min = sol.findMin(num, 6);
//    std::cout << min << "\n";
    
    
//    int res = sol.myPow(2, -2);
//    std::cout << res << "\n";
    
//    int *num = sol.printArray(10);
//    for (int i = 1; i < 100; i++) {
//        printf( "*(num + %d) : %d\n", i, *(num + i));
//
//    }
    
    
    // 取地址运算符& 间接寻址运算符
    
//    int var = 5;
//    int *ptr = NULL;
//    ptr = &var;
//
//    std::cout << ptr << "\n";
//    std::cout << *ptr << "\n";
    
//    int res = sol.oneCount(100);
//    std::cout << res << "\n";
//    testPoint();
    


    return 0;
}
