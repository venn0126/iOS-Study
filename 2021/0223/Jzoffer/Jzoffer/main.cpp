//
//  main.cpp
//  Jzoffer
//
//  Created by Augus on 2021/2/23.
//

#include <iostream>
#include <cmath>
#include <deque>
#include <chrono>

#include <vector>
#include <algorithm>
#include <set>
#include <unordered_map>
#include <queue>



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
        int **c = new int*[n+1];
        for (int i = 0; i < n+1; i++) {
            c[i] = new int[m+1];
        }
        
        
        // 递归填表
        for (int i = 0; i <= n; i++) {
            for (int j = 0; j <= m; j++) {
                if (i == 0 || j == 0) {
                    c[i][j] = 0;
                } else if(s1[i-1] == s2[j-1]) {
                    c[i][j] = c[i-1][j-1] + 1;
                } else {
                    c[i][j] = max(c[i-1][j], c[i][j-1]);
                }
            }
        }
        
        
        // 释放二维数组
        for (int i = 0; i < n+1; i++) {
            delete []c[i];
        }
        delete []c;
        return c[n][m];
    }
    


    /// deque
    
    void testDeque() {
        
        // 创建一个有10个元素的双端队列，元素类型为int
        deque<int> a(5);
        
        // 给deque赋值
        for (int i = 0; i < 5; i++) {
            a[i] = i;
        }
        // 输出a的值
        for (int i = 0; i < 5; i++) {
            cout << &a[i] << "\n";
        }
        cout << endl;
        
        // 在头部加入数据5
        a.push_front(5);
        for (int i = 0; i < a.size(); i++) {
            cout << &a[i] << "\n";
        }
        cout << endl;
        
        // 在尾部加入数据11
        a.push_back(11);
        for (int i = 0; i < a.size(); i++) {
            cout << &a[i] << "\n";
        }
        cout << endl;
        
        // 在头部删除数据
        a.pop_front();
        for (int i = 0; i < a.size(); i++) {
            cout << &a[i] << "\n";
        }
        cout << endl;
        
        // 在尾部删除数据
        a.pop_back();
        for (int i = 0; i < a.size(); i++) {
            cout << &a[i] << "\n";
        }
        cout << endl;
        
        
        // emplace_back 省去了复制和移动的过程
        a.emplace_front(6);
        for (int i = 0; i < a.size(); i++) {
            cout << &a[i] << "\n";
        }
        cout << endl;
        
        // emplace_front 省去了复制和移动的过程
        a.emplace_back(12);
        for (int i = 0; i < a.size(); i++) {
            cout << a[i] << "\n";
        }
        cout << endl;
        
        
        // insert 需要移动和复制元素
//        a.insert(a.begin() + 4, 18);
//        for (int i = 0; i < a.size(); i++) {
//            cout << &a[i] << "\n";
//        }
//        cout << endl;
        
        
        // emplace 不需要移动和复制元素-》在容器指定位置构造元素
        a.emplace(a.end() + 1, 10);
        for (int i = 0; i < a.size(); i++) {
            cout << a[i] << "\n";
        }
        cout << endl;
        
        
    }
    
    // test insert and emplace
    void testEmplace() {
//        {
//
//            const auto start = chrono::high_resolution_clock::now();
//            vector<string> v;
//            for(size_t i = 0; i < 9999999; ++i)
//            v.push_back(string("hello")
//                        );
//
//            cout << chrono::duration_cast<chrono::milliseconds>(chrono::high_resolution_clock::now() - start).count() << endl;
//        }
//
//        {
//            const auto start = chrono::high_resolution_clock::now();
//            deque<string> v;
//            for(size_t i = 0; i < 9999999; ++i)
//                v.push_back(string("hello")
//            );
//
//            cout << chrono::duration_cast<chrono::milliseconds>(chrono::high_resolution_clock::now() - start).count() << endl;
//        }
        
        int count = 999999;
        
        {
            const auto start = chrono::high_resolution_clock::now();
            
            deque<int> v(count);
            for (int i = 0; i < count; i++) {
                v.insert(v.begin() + i, i);
            }
            
            cout << chrono::duration_cast<chrono::milliseconds>(chrono::high_resolution_clock::now() - start).count() << endl;
        }
        
        {
            const auto start = chrono::high_resolution_clock::now();
            deque<int> v(count);
            for (int i = 0; i < count; i++) {
                v.emplace(v.begin() + i, i);
            }
            
            cout << chrono::duration_cast<chrono::milliseconds>(chrono::high_resolution_clock::now() - start).count() << endl;
        }

    }
    
    
    void swap(int a,int b){
        a = a ^ b;// 11 ^ 10 = 01
        b = a ^ b;// 01 ^ 10 = 10;
        a = a ^ b;// 01 ^ 11 = 11
        
    }
    
    /// 插入排序 平均==最坏=n*n 空间复杂度O1 稳定
    // 从第二个位置开始进行比较，如果前者大于后者，进行对调，前者下标--
    void insertion_sort(int arr[],int len) {
        
        for (int i = 1; i < len; i++) {
            int key = arr[i];
            int j = i - 1;
            while ((j >= 0 ) && (key < arr[j])) {
                arr[j + 1] = arr[j];
                j--;
            }
            arr[j+1] = key;
        }
    }
    
    /// 冒泡排序 平均==最坏 n*n 空间复杂度O(1) 稳定
    // 从开头位置和其余的元素依次比较，如果前者大于后者进行互换位置
    void bubble_sort(int arr[],int len) {
        int count = len - 1;// 总共需要比较len-1次
        for (int i = 0; i < count; i++) {
            bool flag = false;//是否需要排序标识符
            for (int j = 0; j < count - i; j++) {
                // 如果前者大于后者进行位置互换 并设置标识符为true
                if (arr[j] > arr[j+1]) {
                    swap(arr[j], arr[j+1]);
                    flag = true;
                }
                // 如果标识符为NO则没有进行互换证明有序则跳出当前内循环
                if (!flag) {
                    break;
                }
            }
        }
    }
    
    /// 选择排序 平均==最坏==n*n 空间O(1) 不稳定
    // 首先在未排序的序列中找到最小的，存放到排序序列的开头
    // 然后从剩于未排序元素中继续寻找最小元素，然后放到已经排序的末尾
    void selection_sort(int arr[],int len) {
        int count = len - 1;// 总共需要比较len-1次
        for (int i = 0; i < count; i++) {
            int min = i;
            
            // 每轮需要比较的次数len - i次
            for (int j = i + 1; j < len; j++) {
                if (arr[j] < arr[min]) {
                    // 记录目前能找到的最小值的下标
                    min = j;
                }
            }
            
            // 将找到的最小值的下标和i位置的值进行交换
            if (i != min) {
                swap(arr[min], arr[i]);
            }
        }
    }
    
    /// 迭代斐波那契
    
    long long Fibb(unsigned n) {
        
        int res[2] = {0,1};
        if (n < 2) {
            return res[n];
        }
        
        long long fib0 = 0;
        long long fib1 = 1,fib2 = 0;
        for (unsigned int i = 2; i < n;i++) {
            fib0 = fib1  + fib2;
            
            fib2 = fib1;
            fib1 = fib0;
        }
        
        
        return fib0;
    }
    
    // 二分查找
    int binary_search(int *a,int len,int goal) {
        
        int low = 0;
        int high = len - 1;
        
        while (low <= high) {
            int mid = (high - low) / 2 + low;
            if (a[mid] == goal) {
                return a[mid];
            }else if(a[mid] > goal){
                high = mid - 1;
            }else {
                low = mid + 1;
            }
        }
        
        return -1;
    }
    
    // 是否是2的幂
    bool isPowerOfTwo(int n) {
        
        if (n == 1) {
            return true;
        }
        
        if (n >= 2 && n % 2 == 0) {
            return (isPowerOfTwo(n/2));
        }
        
        return false;
    }
    
   // 是否是3的幂
    bool isPowerOfThree(int n) {
//        if (n == 1) {
//            return true;
//        }
//
//        if (n >= 2 && n % 3 == 0) {
//            return isPowerOfThree(n/3);
//        }
        
        if (n > 1) {
            while (n % 3 == 0) {
                n = n / 3;
            }
        }
        return n == 1;
    }
    
    /// 是否是质数 除了1和它本身外，不能被其他自然数整除的数
    // 1 2 3 4 5 ,n=5,5 % (2,3,4)
    bool isPrime(int n) {
        if (n < 2) {
            return true;
        }
        for (int i = 2; i < n; i++) {
            if (n % i == 0) {
                return false;
            }
        }
        return true;
    }
    
    /// 质数的个数
    // input 10 output 4
    int countOfPrime(int n) {
        
        int count = 0;
        
        if (n <= 2) {
            count++;
        }
        
        for (int i = 2; i <= n; i++) {
            if (isPrime(i)) {
                count++;
            }
        }
        
        return count ;
    }
    
    // 是否是丑数 ugly
    bool isUgly(int n){
        
        if (n == 0) {
            return false;
        }else if(n == 1){
            return true;
        }else {
            
            while (n % 2 == 0) {
                n /= 2;
            }
            
            while (n % 3 == 0) {
                n /= 3;
            }
            
            while (n % 5 == 0) {
                n /= 5;
            }
            if (n == 1) {
                return true;
            }
        }
        
        return false;
    }
    
    // binary search
    
    int binarySearch1(int a[],int len,int goal) {
        
        int high = len - 1;
        int low = 0;
        while (low < high) {
            // 0 1 2 3 4 5 6
            // 1 3 8 0 5 2 7
           int mid = (high - low) / 2 + low;
            if (a[mid] == goal) {
                return a[mid];
            }else if(a[mid] > goal){
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }
        
        return -1;
    }
    
    // ******************* Sort ************************

    
    /// 插入  最坏==平均n*n 空间O(1) 稳定

    
    /// 冒泡 最坏==平均n*n 空间O(1) 稳定


    /// 选择 最坏==平均n*n 空间O(1) 不稳定


    /// 快速 最坏n*n,平均O(nlogn) 空间O(logn) 不稳定



    
   // ******************* ListNode ************************
    
    /// 反转链表

    
    /// 链表是否有环


    
    /// 两个链表的交点



    /// 合并两个链表


    /// 找到链表倒数第K个节点 && 删除
 


    /// 倒序打印链表

    
        
    /// 删除某个节点

    
    /// 删除重复节点

    /// 删除链表里某个值的所有节点



    /// 左右临界值分离（将小于和大于给定值的节点划分到链表两侧）



    /// 左右奇偶index值分离 odd:奇数 even偶数
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    ListNode *oddEvenList(ListNode *head) {
        
        if (head == nullptr) {
            return head;
        }
        
        ListNode *evenHead = head->next;
        ListNode *odd = head;
        ListNode *even = evenHead;
        
        while (even != nullptr || even->next != nullptr) {
            odd->next = even->next;
            odd = odd->next;
            even->next = odd->next;
            even = even->next;
        }
        
        odd->next = evenHead;
        
        return head;
    }
    

    
    // ******************* Array Questions ************************

    /// 检测数组中是否包含重复的元素
    
    
    /// 出现次数 超过数组长度一半的元素

    

    /// 数组中只出现一次的数字，其余的都是成对出现


    /// 寻找数组中缺失的数字


    /// 将所有的0移动到数组末尾 Move Zeros O(n) O(1)


    /// 移除数组中等于某个值的元素 返回移除后数组的长度

    

    /// 三色旗帜问题
    
    /// (有序)数组内部的两个值的和为目标值


    
    /// 无序数组和大于或等于某值的最小子数组,返回子数组的元素个数



    /// 两个数组的交点元素

    
    /// 前 K 个高频元素
    
    
    /**
     
     哈希----堆排序：时间复杂度O(nlogK),O(n)
     首先将数组进行HashMap遍历一次，将元素值作为key，出现频次作为value
     维护一个元素为K的最小堆
     每次都将新的元素和堆顶元素（最小堆元素）进行比较
     如果新的元素的频率比堆顶的元素大，则弹出堆顶元素，将新的元素添加到堆中
     最后，堆中的K个元素即为前K个高频元素
     
     哈希---桶排序：时间复杂度O(n),空间复杂度O(n)
     首先将数组进行HashMap遍历一次，将元素值作为key，出现频次作为value
     新建一个数组，将哈希表中频次值作为数组下标，然后倒序遍历，取出K个值
     
     
     */
    vector<int> topKFrequent(vector<int> arr,int k) {
        unordered_map<int, int> m;
        priority_queue<pair<int, int>> q;
        vector<int> res;
        // 把元素作为key进行赋值map
        for (auto a : arr) {
            ++m[a];
//            cout << a << " 出现次数: " << m[a] << "\n" << endl;
        }
        
        // map的遍历器
        for (auto it : m) {
            // second: 出现的频次
            // first: 元素
//            printf("it---second(%d)----first(%d)\n",it.second,it.first);
            q.push({it.second,it.first});
        }
        
        for (int i = 0; i < k; i++) {
            res.push_back(q.top().second);
            q.pop();
        }
        
        
        return res;
    }
        
    /// 数组中第K大元素
    int findKthLargest(vector<int> arr,int k) {
        
//        sort(arr.begin(), arr.end());
//        return arr[arr.size() - k];
        
        // 在容器范围内，就地建堆，保证最大值在所给范围的最前面，其他值的位置不确定
//        make_heap(arr.begin(), arr.end());
//        for (int i = 0; i < k; i++) {
        // 将堆顶(所给范围的最前面)元素移动到所给范围的最后，并且将新的最大值置于所给范围的最前面
//            pop_heap(arr.begin(), arr.end());
        // 销毁并移除最后一个元素
//            arr.pop_back();
//        }
//
//        return arr[0+1];
        
        
//        sort(arr.begin(), arr.end());
//        return arr[arr.size() - k];
        
        return 0;
        
    }
    
    
    /// 无序数组的两个元素和为目标值 时间复杂度O(n),空间O1
    
    

    /// 合并两个有序的数组
    // arr1 {1,2,3,0,0,0} m=3;
    // arr2 {4,5,6} n = 3;
    
    struct TreeNode {
        int val;
        TreeNode *left;
        TreeNode *right;
        TreeNode(int x) : val(x),left(NULL),right(NULL) {}
    };
    
    // ******************* Tree Questions ************************


    /// 二叉树深度
    
    /// 反转二叉树
    
    /// 是否是平衡树(一棵空树或它的任意节点的左右两个子树的高度差的绝对值均不超过1。)
    
    /// 是否是镜像树（这棵树的左右子树对称节点是镜像对称）
    
    ///  树是否相等

    
    
    // ******************* String Questions ************************

    ///  反转字符串
    string reverseString(string s) {
//        int left = 0;
//        int right = (int)s.size() - 1;
//        while (left < right) {
//            char tmp = s[left];
//            s[left++] = s[right];
//            s[right--] = tmp;
//        }
    
//        reverse(s.begin(), s.end());

        
        

        return s;
        
    }
    
    /// 最长子串或者子序列 子序列，不连续，子串，连续 动态规划思想

    
    


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

void test(void *p) {
    cout << "p is pointer" << p << endl;
}

void test(int n) {
    cout << "n is int num" << n << endl;
}

void testArray(vector<int> arrs) {
    
     int nu = arrs[0];
     std::cout << "Hello," << nu << "\n" << endl;
    
    

    
//        int l = 1;
//        int r = 2;
//        int arr[] = {l+1,r+2};
//        for (int i = 0; i < 2; i++) {
//            std::cout << "Hello," << arr[i] << "\n" << endl;
//
//        }
//
//        vector<int> nums = vector<int>(arr,arr+2);
//        for (int i = 0; i < 2; i++) {
//            std::cout << "word," << nums[i] << "\n" << endl;
//        }
    
    //    set<int> sets1 = {1,2,3};
    //    int tmp = 1;
    //    if (sets1.find(tmp) != sets1.end() ) {
    //        printf("found \n");
    //    } else {
    //        printf("not found\n");
    //    }

}

void printfArray(vector<int>& arr) {
    for (int i = 0; i < arr.size(); i++) {
        std::cout << "index:" << i << " value:" << arr[i] << "\n" << endl;
    }
}


int main(int argc, const char * argv[]) {
    // insert code here...
    std::cout << "Hello, World!\n";
    

    Solution sol;

//    vector<int> arr = {3,1,1,4,6,4};
//    vector<int> res = sol.topKFrequent(arr, 3);
//    printfArray(res);
//    int res = sol.findKthLargest(arr, 1);
//    vector<int> res = sol.topKFrequent(arr, 2);
//    printf("res--%d\n",res);
//    printfArray(res);

    
//    sol.testDeque();
//    sol.testEmplace();
//    string str="12345";
//    string s = sol.reverseString(str);
//    cout << s << "\n" << endl;
    
//    string str="123459";
//    int i = 0,j = (int)str.size() - 1;
//    while(i < j)
//        swap(str[i++],str[j--]);
//
//    cout<< str << "\n" << endl;
    
    
//    string strOne = "abcdefg";
//    string strTwo = "adefgwgeweg";
//    int res = sol.lccss(strOne, strTwo);
//    cout<< res << "\n" << endl;

    
    
    
//    int *m = addition(5, 6);
//    std::cout << *m << "\n";
//
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
