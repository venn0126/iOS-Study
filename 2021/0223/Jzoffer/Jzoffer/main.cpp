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

#include <unordered_map>

#include <stack>
#include <random>



using namespace std;

struct ListNode {
    int val;
    ListNode *next;
    ListNode(int x) : val(x),next(NULL) {};
};



void printfArray(vector<int> arr) {
    for (int i = 0; i < arr.size(); i++) {
        std::cout << "index:" << i << " value:" << arr[i] << "\n" << endl;
    }
}



class Solution {
public:
    /// 获取两个链表的交点
    
    
    int listNodeOfLen(ListNode *root) {
        int len = 0;
        while (root) {
            len++;
            root = root->next;
        }
        return len;
    }
    
    
    ListNode *getIntersectionNode(ListNode *headA, ListNode *headB) {
        
        if (headA == NULL || headB == NULL) {
            return NULL;
        }
        
        int alen = listNodeOfLen(headA);
        int blen = listNodeOfLen(headB);
        int offset = alen - blen;
        
        ListNode *pa = headA;
        ListNode *pb = headB;
        
        for (int i = 0; i < abs(offset); i++) {
            if (offset > 0) {
                pa = pa->next;
            } else {
                pb = pb->next;
            }
        }
        
        while (pa && pb) {
            if (pa == pb) {
                return pb;
            }
            pa = pa->next;
            pb = pb->next;
        }
        return nullptr;
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
    
    ListNode * delDubleNode(ListNode *head,int val) {
    
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
        
    void swap(int a,int b){
        a = a ^ b;// 11 ^ 10 = 01
        b = a ^ b;// 01 ^ 10 = 10;
        a = a ^ b;// 01 ^ 11 = 11
        
    }
    
    void swap_ptr(int *a,int *b) {
        int tmp = *a;
        *a = *b;
        *b = tmp;
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
        
        
        for (int i = 0; i < len; i++) {
            std::cout << "index:" << i << " value:" << arr[i] << "\n" << endl;
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
    
    
    /// 快速排序 最坏O(n*n) 平均O(nlogn)，空间O(logn)
    void quick_sort(int *arr,int low,int high) {
        if (low < high)
        {
            int i = low;
            int j = high;
            int k = arr[low];
            while (i < j)
            {
                while(i < j && arr[j] >= k)     // 从右向左找第一个小于k的数
                {
                    j--;
                }
     
                if(i < j)
                {
                    arr[i++] = arr[j];
                }
     
                while(i < j && arr[i] < k)      // 从左向右找第一个大于等于k的数
                {
                    i++;
                }
     
                if(i < j)
                {
                    arr[j--] = arr[i];
                }
            }
     
            arr[i] = k;
     
            // 递归调用
            quick_sort(arr, low, i - 1);     // 排序k左边
            quick_sort(arr, i + 1, high);    // 排序k右边
        }
    }
    
    /// 归并排序 最好nlogn 最坏n*n，空间O(n)
    void mergeSort(vector<int> arr,int start,int end) {
        
        if (start < end) {
            int mid = (start + end) / 2;
            mergeSort(arr,start,mid);
            mergeSort(arr, mid+1, end);
            mergeSecondFunc(arr, start, mid, end);
        }
    }
    vector<int> mergeSecondFunc(vector<int> arr,int start,int mid,int end) {
        
        int len = end -start + 1;
        int temp[len];
        int p1 = start,p2 = mid+1,p = 0;
        while (p1 <= mid && p2 <= end) {
            if (arr[p1] < arr[p2]) {
                temp[p++] = arr[p1++];
            } else {
                temp[p++] = arr[p2++];
            }
        }
        
        while (p1 <= mid) {
            temp[p++] = arr[p1++];
        }
        
        while (p2 <= end) {
            temp[p++] = arr[p2++];
        }
        for (int i = 0; i < len; i++) {
            arr[i+start] = temp[i];
        }
        
        return arr;
    }
    
    /// 桶排序 最好的时间复杂度O(n)，空间复杂度O(n)
    /**
     
     时间复杂度
     假设待排序列数据元素个数为n，桶的数量为m；那么平均每个桶中的数据元素个数为k = n / m，对每个桶中的数据元素进行快速排序，那么每个桶中的时间复杂度为O(k * logk)，也就是(n / m) * O(log (n / m))，总的时间复杂度为O(n * log(n / m))；当桶的个数m接近数据元素个数时，那么log(n / m)就是一个常数，此时时间复杂度为O(n)。

     空间复杂度

     实现过程中，所有桶大小之和等于待排序列数据元素个数；对桶内数据元素进行排序时，可以使用快速排序和归并排序，快速排序的时间复杂度为O(1)，归并排序的时间复杂度为O(n)；所以桶排序的时间复杂度为O(n)。
     */
    
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
    
    bool isPowerOfTwo2(int n) {
        
        if (n == 1) {
            return true;
        }
        if (n == 0) {
            return false;
        }
        return (n & (n-1)) == 0;
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
    void insertSort(vector<int> arr) {
        for (int i = 1; i < arr.size(); i++) {
            int j = i - 1;
            int k = arr[i];
            while (j > 0 && k < arr[i]) {
                arr[j+1] = arr[j];
            }
            arr[j+1] = k;
        }
    }


    /// 冒泡 最坏==平均n*n 空间O(1) 稳定
    void bubbleSort(vector<int> arr) {
        for (int i = 0; i < arr.size() - 1; i++) {
            for (int j = 0; j < arr.size() - 1 - i; j++) {
                if (arr[j] > arr[j+1]) {
                    std::__1::swap(arr[j], arr[j+1]);
                }
            }
        }
    }


    /// 选择 最坏==平均n*n 空间O(1) 不稳定
    void selectSort(vector<int> arr) {
        for (int i = 0; i < arr.size() - 1; i++) {
            int min = i;
            for (int j = i+1; j < arr.size(); j++) {
                if (arr[j] < arr[min]) {
                    min = j;
                }
            }
            if (i != min) {
                std::__1::swap(arr[i], arr[min]);
            }
        }
    }


    /// 快速 最坏n*n,平均O(nlogn) 空间O(logn) 不稳定


    /// 归并 O(n) nlogn 空间O(n)

    


   // ******************* ListNode ************************
    
    
    struct GTListNode {
        
        int val;
        GTListNode *next;
        GTListNode(int x) : val(x),next(NULL) {};
    };
    
    /// 初始化链表
    ListNode *initListNode(void) {
        
        ListNode *head = nullptr;
        // Create first node with 12.5
        head = new ListNode(-1); // Allocate new node
        head->val = 3;    // Store the value
        head->next = nullptr; // Signify end of list
        
        // Create second node with 13.5
        ListNode *secondPtr = new ListNode(-1);
        secondPtr->val = 7;
        secondPtr->next = nullptr; // Second node is end of list
        head->next = secondPtr; // First node points to second
        
        
        ListNode *thirdPtr = new ListNode(-1);
        thirdPtr->val = 10;
        thirdPtr->next = nullptr; // third node is end of list
        secondPtr->next = thirdPtr;//
        
        // Print the list
        cout << "First item is " << head->val << endl;
        cout << "Second item is " << head->next->val << endl;
        cout << "Third item is " << head->next->next->val << endl;

        
        return head;
    }
    
    
    
    
    /// 反转链表
    ListNode *revserseListNode(ListNode *head) {
        if (!head) {
            return nullptr;
        }
        
        ListNode *cur = head;
        ListNode *pre = nullptr,*tmp = nullptr;
        while (cur) {
            tmp = cur->next;
            cur->next = pre;
            pre = cur;
            cur = tmp;
        }
        
        return pre;
    }


    
    /// 链表是否有环
    bool hasCycle(ListNode *head) {
        if (!head) {
            return false;
        }
        ListNode *slow = head;
        ListNode *fast = head->next;
        while (fast && fast->next) {
            slow = slow->next;
            fast = fast->next->next;
            if (slow == fast) {
                return true;
            }
        }
        return false;
    }


    /// 两个链表的交点


    /// 合并两个链表
    ListNode *mergeListNode(ListNode *head1,ListNode *head2) {
        
        if (!head1 && !head2) {
            return nullptr;
        }
        
        if (!head1) {
            return head2;
        }
        if (!head2) {
            return head1;
        }
        
        ListNode *l3 = nullptr;
        if (head1->val < head2->val) {
            l3 = head1;
            l3->next = mergeListNode(l3->next, head2);
        } else {
            l3 = head2;
            l3->next = mergeListNode(head1, l3->next);
        }
        
        return l3;
    }

    /// 找到链表倒数第K个节点 && 删除
    
    void delTailKthListNode(ListNode *head,int k) {
        if (!head) {
            return;
        }
        
        ListNode *p1 = head;
        ListNode *p2 = head;
        for (int i = 0; i < k-1; i++) {
            if (p1->next) {
                p1 = p1->next;
            } else {
                return;
            }
        }
        while (p1->next) {
            p1 = p1->next;
            p2 = p2->next;
        }
        
        p2->val = p2->next->val;
        p2->next = p2->next->next;
    }


    /// 倒序打印链表
    void printOfReverse(ListNode *root) {
        
        if (root) {
           
            if (root->next) {
                printOfReverse(root->next);
            }
            cout << "the node is: " << root->val << "\n";
        }
    }
    
    
    /// 删除某个节点
    
    void delNode(ListNode *head) {
        if (!head || !head->next) {
            return;
        }
        
        head->val = head->next->val;
        head->next = head->next->next;
        
    }

    /// 删除链表内重复的节点，保留单个节点
    void removeDuplicateNodes(ListNode *head) {
        
        if (!head) {
            return;
        }
        ListNode *cur = head;
        while (cur->next) {
            if (cur->val == cur->next->val) {
                ListNode *delNode = cur->next;
                cur = delNode->next;
//                delNode(delNode);
            } else {
                cur = cur->next;
            }
        }
    }
 
    
    /// 删除链表里某个值的所有节点
    ListNode *delAllDuplicateNodes(ListNode *head,int k) {
        if (!head) {
            return nullptr;
        }
        ListNode *fakeHead = new ListNode(-1);
        fakeHead->next = head;
        ListNode *cur = fakeHead;
        while (cur->next) {
            if (cur->next->val == k) {
                ListNode *delNo = cur->next;
                cur = delNo->next;
                delNode(delNo);
            } else {
                cur = cur->next;
            }
        }
        ListNode *returnHead = fakeHead->next;
        delNode(fakeHead);
        return returnHead;
    }


    /// 左右临界值分离（将小于和大于给定值的节点划分到链表两侧）
    ListNode *partitionLinkList(ListNode *head,int k) {
        if (!head) {
            return nullptr;
        }
        
        ListNode *left = new ListNode(-1);
        ListNode *p = left;
        
        ListNode *right = new ListNode(-1);
        ListNode *q = right;
        
        while (head != nullptr) {
            if (head->val < k) {
                p->next = head;
                p = p->next;
            } else {
                q->next = head;
                q = q->next;
            }
            
            head = head->next;
        }
        
        q->next = nullptr;
        p->next = right->next;
        return left->next;
    }
    
    
    /// 左右奇偶index值分离 odd:奇数 even偶数

    

    /// 股票最大收益 (一次买入，一次卖出)
    int maxProfit(vector<int> arr) {
        
        if (arr.size() == 0) {
            return -1;
        }
        
        int minPrice = arr[0];
        int maxProfit = 0;
        for (int i = 1; i < arr.size(); i++) {
            if (arr[i] < minPrice) {
                minPrice = arr[i];
            } else if(arr[i] - minPrice > maxProfit) {
                maxProfit = arr[i] - minPrice;
            }
        }
        return maxProfit;
    }
    
    /// 不限制次数 在最低点买入 最高点卖出
    int maxProfitNoneTimes(vector<int> arr) {
        if (arr.size() == 0) {
            return -1;
        }
        int maxProfit = 0;
        for (int i = 1; i < arr.size(); i++) {
            if (arr[i] > arr[i-1]) {
                maxProfit += arr[i] - arr[i-1];
            }
        }
        return maxProfit;
    }
    
    /// k次买入卖出股票的最大收益 DP思想
    int maxProfitKTimes(vector<int> arr,int k) {
        if (arr.size() == 0) {
            return -1;
        }
        
        // 最大行
        int n = (int)arr.size();
        // 最大列
        int m = k * 2 + 1;
        
        // 初始化结果数组
        int res[m];
        
        //填充状态
        for (int i = 0; i < m; i+=2) {
            res[i] = -arr[0];
        }
        
        //自底向上填充数据
        for (int i = 1; i < n; i++) {
            for (int j = 1; j < m; j++) {
                if ((j & 1 )== 1) {// 奇数-
//                    cout << j << "奇" << "\n";
                    res[j] = max(res[j], res[j-1]-arr[i]);
                } else {
                    res[j] = max(res[j], res[j-1]+arr[i]);
                }
            }
        }
        
        return res[m-1];
    }
    
    
    /// 股票最大收益 k次买入卖出
    int maxProfitToKth(vector<int> arr,int k) {
        
        if (arr.size() == 0) {
            return -1;
        }
        
        int n = (int)arr.size();
        int m = k * 2 + 1;
        int res[m];
        
        for (int i = 1;i < m; i+=2) {
            res[i] = -arr[0];
        }
        
        for (int i = 1; i < n; i++) {
            for (int j = 1; j < m; j++) {
                if ((j & 1) == 1) {
                    res[j] = max(res[j], res[j-1] - arr[i]);
                } else {
                    res[j] = max(res[j], res[j-1] + arr[i]);

                }
            }
        }
        
        return res[m-1];
    }
    
    
    
    
    ListNode *oddEvenList(ListNode *head) {
        
        if (head == nullptr) {
            return head;
        }
        
        ListNode *evenHead = head->next;
        ListNode *odd = head;
        ListNode *even = evenHead;
        
        while (even || even->next) {
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
    bool hasDuplicateItems(vector<int> arr) {
        set<int> s1(arr.begin(),arr.end());
        return s1.size() != arr.size();
    }
    
    
    /// 出现次数 超过数组长度一半的元素
    int numOccurMoreHalfOfArray(vector<int> nums) {
        
        stack<int> stk;
                        
        for (int i = 0; i < nums.size(); i++) {
            if (stk.empty() || stk.top() == nums[i]) {
                stk.push(nums[i]);
            } else {
                stk.pop();
            }
        }
        return stk.top();
    }

    

    /// 数组中只出现一次的数字，其余的都是成对出现
    int onceNum(vector<int> arr) {
        int res = -1;
        for (int i = 0; i < arr.size(); i++) {
            res ^= arr[i];
        }
        return res;
    }

    /// 寻找数组中缺失的数字
    
    int missNum(vector<int> arr) {
        int res = -1;
        int i = 0;
        for (i = 0; i < arr.size(); i++) {
            res = arr[i] ^ i ^ res;
        }
        return res ^ i;
    }


    /// 将所有的0移动到数组末尾 Move Zeros O(n) O(1)
    
    void moveZeroTail(vector<int> arr) {
        int j = 0;
        for (int i = 0; i < arr.size(); i++) {
            if (arr[i] != 0) {
                if (i != j) {
                    std::__1::swap(arr[i], arr[j++]);
                } else {
                    j++;
                }
            }
        }
    }


    /// 移除数组中等于某个值的元素 返回移除后数组的长度
    int removeItemEqualK(vector<int> arr,int k) {
        int j = 0;
        for (int i = 0; i < arr.size(); i++) {
            if (arr[i] != 0) {
                if (i != j) {
                    arr[j] = arr[i];
                }
                j++;
            }
        }
        return j;
    }


    /// 三色旗帜问题

    
    /// (有序)数组内部的两个值的和为目标值


    /// 无序数组和大于或等于某值的最小子数组,返回子数组的元素个数
    int minSumArray(vector<int> arr,int k) {
        
        int l = 0;
        int r = -1;
        int sum = 0;
        int len = (int)arr.size();
        int res = len + 1;
        while (l < r) {
            if (r+1 < len && sum < k) {
                sum += arr[r];
                r++;
            } else {
                sum -= arr[l];
                l++;
            }
            
            if (sum >= k) {
                res = min(res, r-l+1);
            }
        }
        
        if (res == len+1) {
            return 0;
        }
        return res;
        
    }


    /// 两个数组的交点元素
    set<int> intersectionTwoArray(vector<int> arr1,vector<int> arr2) {
        set<int> res;
        set<int> s1(arr1.begin(),arr1.end());
        for (int i = 0; i < arr2.size(); i++) {
            if (s1.find(arr2[i]) != s1.end()) {
                res.insert(arr2[i]);
            }
        }

        return res;
    }


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
    
            
    /// 无序数组中第K大元素
    
    
    /**
     
        childIndex----->parentIndex
        parentIndex =( child - 1) / 2;
        parentIndex =( parentIndex - 1) / 2;
     
     
        parentIndex---->childIndex
        childIndex = 2 * parentIndex  + 1;//left
        childIndex = 2 * parentIndex  + 2;//right
     
        child------>child
        child = child * 2 + 1;left
        child = child * 2  + 2;right
     
        
        parent----->parent
        parent =
     
        
     
     */
    
    /// 小顶堆
    /// 上浮操作(插入节点)
    /// @param arr 待调整的堆
    void upJust(vector<int> arr) {
        int childIndex = (int)arr.size() - 1;
        int parentIndex = (childIndex-1) / 2;
        
        // temp保存插入叶子节点的值，用于最后赋值
        int temp = arr[childIndex];
        while (childIndex > 0 && temp < arr[parentIndex]) {
            // 无需真正交换，单向赋值
            // 把父节点的值赋值给子节点下标arr[9] = 5
            arr[childIndex] = arr[parentIndex];
            // 把父节点下标赋值给子节点下标 childindex = 4
            childIndex = parentIndex;
            // 计算上一个级父节点下标 parentIndex = （4-1）/2
            parentIndex = (parentIndex-1) / 2;
 
        }
        arr[childIndex] = temp;
        
    }
    
 
    /// 待调整堆
    /// @param arr 待调整堆
    /// @param parentIndex 要下沉的父节点
    /// @param length 有效堆的长度
    void downJust(vector<int> arr,int parentIndex,int length) {
                
        // temp 用于保存父节点，用于最后赋值
        int temp = arr[parentIndex];
        int childIndex = 2 * parentIndex + 1;
        while (childIndex < length) {
            // 如果有右孩子，且右孩子的值小于左孩子，定位到右孩子
            if (childIndex + 1 < length && arr[childIndex] > arr[childIndex + 1]) {
                childIndex++;
            }
            
            // 如果父节点小于任何一个值直接退出
            if (temp < arr[childIndex]) {
                break;
            }
            
            // 无需真正交换，直接赋值
            // 值1，index，上级或下级index
            arr[parentIndex] = arr[childIndex];
            parentIndex = childIndex;
            childIndex = childIndex * 2 + 1;
            
        }
        
        arr[parentIndex] = temp;
        
        
    }
    
    // 构建小顶堆
    void buildHeap(vector<int> arr, int k) {
        
        // 从最后一个非叶子节点开始下沉操作
        for (int i = (k-2) / 2; i>=0; i--) {
            downJust(arr, i, k);
//            cout << i << " down " << arr[i] << endl;
        }
        
    }
    
    int topKthLargest(vector<int> arr,int k) {
        
        // 1用前k个元素构建小顶堆O(k)
        buildHeap(arr, k);
        
        // 2继续遍历剩余数组，和堆顶比较O(n-k)
        for (int i = k; i < arr.size(); i++) {
            if (arr[i] > arr[0]) {
                // 替换堆顶元素
                arr[0] = arr[i];
                // 下沉操作 O(logk)
                downJust(arr, 0, k);
            }
        }
        
        // 返回堆顶元素
        return arr[0];
    }

    
    // 分治法

    /**
     将选取第K大数字，转换为第l个最小元素
     int l = arr.size() + 1 - k;
     
     找到最大的元素和下标--随机划分
     
     确定主元后进行比较交换数据，将主元与最右边元素互换位置
     
     
     */
    
    
    /// 合并两个有序的数组
    vector<int> mergeTwoSortArray(vector<int> arr1,vector<int> arr2) {
        
        vector<int> res;
        int m = (int)arr1.size();
        int n = (int)arr2.size();
        int len = m + n - 1;
        while (m > 0 && n > 0) {
            if (arr1[m-1] > arr2[n-1]) {
                res[len] = arr1[m-1];
                m--;
            } else {
                res[len] = arr2[n-1];
                n--;
            }
            len--;
        }
        
        while (n > 0) {
            res[len] = arr2[n-1];
            n--;
            len--;
        }
        return res;
    }
    
    /// 两个元素和为目标值
    vector<int> twoSumOfSort(vector<int> arr,int k) {
        
        vector<int> res;
        int i = 0;
        int j  = (int)arr.size() - 1;
        while (i < j) {
            int temp = arr[i] + arr[j];
            if (temp == k) {
                res.push_back(i+1);
                res.push_back(j+1);
            } else if(temp > k) {
                j--;
            } else {
                i++;
            }
        }
        
        return res;
        
    }
    
    vector<int> twoSumOfNoSort(vector<int> arr,int k) {
        
        vector<int> res;
        unordered_map<int, int> m;
        for (int i = 0; i < arr.size(); i++) {
            int temp = k - arr[i];
            if (m.find(temp) != m.end()) {
                res.push_back(i);
                res.push_back(m[temp]);
                return res;
            }
            
            m[arr[i]] = i;
        }
        return res;
    }

    /// 求两个有序数组的中位数(二分查找)
    double findMediumSortedArrays(vector<int> arr1,vector<int> arr2) {
        
        int n = (int)arr1.size();
        int m = (int)arr2.size();
        int left = (n+m+1)/2;
        int right = (n+m+2)/2;
        int tmp = getKth(arr1, 0, n-1, arr2, 0, m-1,left) +
        getKth(arr1, 0, n-1, arr2, 0, m-1, right);
        
        return tmp * 0.5;
    }
    
    int getKth(vector<int> arr1,int start1,int end1,vector<int> arr2,int start2,int end2,int k) {
        int len1 = end1 - start1 + 1;
        int len2 = end2 - start2 + 1;
        if (len1 > len2) {
            return getKth(arr2, start2, end2, arr1, start1, end1, k);
        }
        if (len1 == 0) {
            return arr2[start2 + k - 1];
        }
        
        if (k == 1) {
            return min(arr1[start1], arr2[start2]);
        }
        
        int i = start1 + min(len1, k/2) - 1;
        int j = start2 + min(len2, k/2) - 1;
        
        if (arr1[i] > arr2[j]) {
            return getKth(arr1, start1, end1, arr2, j+1, end2, k - (j-start2+1));
        } else {
            return getKth(arr1, i+1, end1, arr2, start2, end2, k - (i-start1+1));
        }
        
    }
    
    
    /// 数组全排列 时间复杂度O(n!),空间复杂度O(n)
    int sum = 0;
    void permutation(int array[],int len,int index){
        if(index==len){//全排列结束
            ++sum;
            printArr(array,len);
        }
        else
            for(int i=index;i<len;++i){
                //将第i个元素交换至当前index下标处
                swapArray(array,index,i);
                //以递归的方式对剩下元素进行全排列
                permutation(array,len,index+1);

                //将第i个元素交换回原处
                swapArray(array,index,i);
            }
    }
 
    void swapArray(int* o,int i,int j){
        int tmp = o[i];
        o[i] = o[j];
        o[j] = tmp;
    }
    
    void printArr(int array[],int len){
        printf("{");
        for(int i=0; i<len;++i)
            cout<<array[i]<<" ";
        printf("}\n");
    }
    
    /// 数组去重
    vector<int> deDuplication(vector<int> arr) {
        
        vector<int> res;
        int len = (int)arr.size();
        if (len < 2) {
            return arr;
        }
        
        set<int> s1(arr.begin(),arr.end());
        res.assign(s1.begin(), s1.end());
        
        return res;
    }
    
    // 二维矩阵的最小路径 时间复杂度O(mn),空间复杂度O(mn)
    // 空间可以继续优化 只存储上一行的dp值
    int findMinPath2(vector<vector<int>>& arr) {
        
        
        if (arr.size() == 0 || arr[0].size() == 0) {
            return 0;
        }
        
        int rows = (int)arr.size(),columns = (int)arr[0].size();
        auto c = vector<vector<int>> (rows,vector<int> (columns));
        c[0][0] = arr[0][0];
        
        for (int i = 1; i < rows; i++) {
            c[i][0] = c[i-1][0] + arr[i][0];
        }
        
        for (int j = 1; j < columns; j++) {
            c[0][j] = c[0][j-1] + arr[0][j];
        }
        
        for (int i = 1; i < rows; i++) {
            for (int j = 1; j < columns; j++) {
                c[i][j] = min(c[i-1][j], c[i][j-1]) + arr[i][j];
            }
        }

        return c[rows-1][columns-1];
        
    }
    
    // ******************* Tree Questions ************************

    
    struct TreeNode {
        int val;
        TreeNode *left;
        TreeNode *right;
        TreeNode(int x) : val(x),left(NULL),right(NULL) {}
    };
    


    /// 二叉树深度

    
    /// 反转二叉树

    
    /// 是否是平衡树(一棵空树或它的任意节点的左右两个子树的高度差的绝对值均不超过1。)

    
    /// 是否是镜像树（这棵树的左右子树对称节点是镜像对称）

    ///  树是否相等
    
    /// 二叉树的最近公共祖先
    // root = [3,5,1,6,2,0,8,null,null,7,4];
    // p=5,q=4
    TreeNode *lowestCommonAncestor(TreeNode *root,TreeNode *p,TreeNode *q) {
        
        if (root == p || root == q || !root) {
            return root;
        }
        
        TreeNode *lnode = lowestCommonAncestor(root->left, p, q);
        TreeNode *rnode = lowestCommonAncestor(root->right, p, q);
        if (lnode && rnode) {
            return root;
        }
        return lnode ? lnode : rnode;
    }
    
    // 多叉树公共祖先
    
    struct TNode {
      
        int id;
        vector<TNode *> members;
        
    };
    
    // 1 2 4
    // 1 3(0,5,6) 6
    vector<TNode *> res;
    vector<TNode *> findAllNode(TNode *root,TNode *k) {
        
        if (!root || !k) {
            return res;
        }
        res.push_back(root);
        vector<TNode *> members = root->members;
        for (int i = 0;i < members.size();i++) {
           vector<TNode *> temp = findAllNode(members[i], k);
            if (count(temp.begin(), temp.end(), k)) {
                return temp;
            }
        }
        return res;
    }
    
   
    TNode *mulLowestCommonAncestor(TNode *root,TNode *p,TNode *q) {
        
        if (!root || p == root || q == root) {
            return root;
        }
        
        // 在一侧的判断 或者一次判断得出
        vector<TNode *> temp = root->members;
        if (count(temp.begin(), temp.end(), p) && count(temp.begin(), temp.end(), q)) {
            return root;
        }
 
        // 在两侧的判断
        // 构造两个不同的集合
        vector<TNode *> nodeArray1 = findAllNode(root, p);
        vector<TNode *> nodeArray2 = findAllNode(root, q);
        
        // 求1和2的交点
        set<TNode *> s1(nodeArray1.begin(),nodeArray1.end());
        for (int i = 0; i < nodeArray2.size(); i++) {
            if (s1.find(nodeArray2[i]) != s1.end()) {
                return nodeArray2[i];
            }
        }
        
        return nullptr;
    }
    
    
    struct GTreeNode {
        
        int val;
        GTreeNode *left;
        GTreeNode *right;
        GTreeNode(int x) : val(x), left(NULL), right(NULL) {};
        
    };
        
    /// Traverse 遍历树 从左到右

    vector<int> traverseTree(GTreeNode *root) {
        
        vector<int> res;
        if (!root) {
            return res;
        }
        
        stack<GTreeNode *> s1;
        s1.push(root);
        while (!s1.empty()) {
            GTreeNode *node = s1.top();
            s1.pop();
            res.push_back(node->val);
            
            if (node->left) {
                s1.push(node->left);
            }
            if (node->right) {
                s1.push(node->right);
            }
            
        }
        
        return res;
    }


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
    
    /// 最长公共子串或者子序列 子序列，不连续，子串，连续 动态规划思想
    
    int longestSubStr(string s1,string s2) {
        
        int m = (int)s1.length();
        int n = (int)s2.length();
        
        vector<vector<int>> c(m+1,vector<int>(n+1));
        for (int i = 0; i <= m; i++) {
            for (int j = 0; j <= n; j++) {
                if (i == 0 || j == 0) {
                    c[i][j] = 0;
                } else if(s1[i] == s2[j]) {
                    c[i][j] = c[i-1][j-1] + 1;
                } else {
                    c[i][j] = max(c[i-1][j], c[i][j-1]);
                }
            }
        }
        
        return c[n][m];
    }
    
    
    /// BM 字符串匹配
    
    /// 查找模式串中是否有字符匹配坏字符
    int findChar(string pattern, char badChar,int index) {
        
        for (int i = index - 1; i >= 0; i++) {
            if (pattern[i] == badChar) {
                return i;
            }
        }
        
        return -1;
    }
    
    
    /// boyerMoore
    int boyerMoore(string str,string pattern) {
        
        int strLen = (int)str.length();
        int patternLen = (int)pattern.length();
        
        // 模式串的起始位置
        int start = 0;
        while (start <= strLen - patternLen) {
            int i;
            // 从后向前，逐个比较
            for (i = patternLen-1; i>= 0; i--) {
                if (str[start+i] != pattern[i]) {
                    // 发现坏字符,跳出比较，i记录了坏字符的位置
                    break;
                }
            }
            
            if (i < 0) {
                // 匹配成功，返回第一次匹配的下标位置
                return start;
            }
            
            // 寻找坏字符在模式串中的对应
            int charIndex = findChar(pattern, str[start+i], i);
            // 计算坏字符产生的位移
            // 坏字符规则(后移位数 = 好后缀的位置 - 搜索词中的上一次出现位置)
            // 如果没有出现上一次出现位置，直接是-1
            int bcOffset = charIndex >= 0 ? i - charIndex : i+1;
            
            // 如果存在好后缀
//            if (i < patternLen-1) {
//
//                int goodIndex = findChar(pattern, pattern[patternLen-1], patternLen -1);
//                // 好后缀规则(后移位数 = 好后缀的位置 - 搜索词中的上一次出现位置)
//                int gcOffset = (patternLen -1) - goodIndex;
//                if (gcOffset > bcOffset) {
//                    bcOffset = gcOffset;
//                }
//            }
            
            start += bcOffset;
            
        }
        
        return -1;
    }
    
    
    /// KMP 字符串搜索
    
    /// kmp-生成部分匹配数组
    vector<int> nexts(string pattern) {
        
        // 模版字符串长度
        int len = (int)pattern.length();
        int next[len];
        // 预先填充，第一个字符的前后缀的最大长度为0
        next[0] = 0;
        // j 最大前后缀长度
        int j = 0;
        // i 模版字符串下标
        // 从第二个字符开始遍历
        for (int i = 1;i < len; i++) {
            // 递归的求出P[1]···P[i]的最大的相同的前后缀长度j
            while (j > 0 && pattern[i] != pattern[j]) {
                j = next[j-1];
            }
            
            if (pattern[i] == pattern[j]) {
                j++;
            }
            
            next[i] = j;
        }
        
        return vector<int>{next,next+len};
    }
    /// kmp 主函数
    int kmp(string str,string pattern) {
        
        // 生成部分匹配数组
        vector<int> next = nexts(pattern);
        int strLen = (int)str.length();
        int patternLen = (int)pattern.length();
        // 匹配字符串游标
        int j = 0;
        // 遍历主字符串
        for (int i = 0; i < strLen; i++) {
            // 坏字符
            while (j > 0 && str[i] != pattern[j]) {
                j = next[j-1];
            }
            if (str[i] == pattern[j]) {
                j++;
            }
            
            if (j == patternLen) {
                // 匹配成功
                return i - patternLen + 1;
            }
        }
        return -1;
    }
    
    
    /// kmp,匹配字符串

    
    /// 股票最大收益
    
    
    /// 两个数字字符串相加求和
    string addString(string s1,string s2) {
        
        // add:是否有进位
        int i = (int)s1.length() - 1,j = (int)s2.length() - 1,add = 0;
        string res = "";
        while (i >=0 || j>=0 || add != 0) {
            int x = i >= 0 ? s1[i] - '0' : 0;
            int y = j >= 0 ? s2[j] - '0' : 0;
            int temp = x + y + add;
            res.push_back('0' + temp % 10);
            add = temp / 10;
            i--;
            j--;
        }
        reverse(res.begin(), res.end());
        
        return res;
    }
    
    /// 两个有序数组求中位数

    double middleNumSortedArrays(vector<int> arr1,vector<int> arr2) {
        int n = (int)arr1.size();
        int m = (int)arr2.size();
        
        int left = (n+m+1)/2;
        int right = (n+m+2)/2;
        
        int temp = getKth0(arr1, 0, n-1, arr2, 0, m-1, left) + getKth0(arr1, 0, n-1, arr2, 0, m-1, right);
        
        return temp * 0.5;
    }
    
    int getKth0(vector<int> arr1,int start1,int end1,vector<int> arr2,int start2,int end2,int k) {
        
        int len1 = end1 - start1 + 1;
        int len2 = end2 - start2 + 1;
        
        if (len1 > len2) {
            return getKth0(arr2, start2, end2, arr1, start1, end1, k);
        }
        
        if (len1 == 0) {
            return arr2[start2 + k - 1];
        }
        
        if (k == 1) {
            return min(arr2[start2], arr1[start1]);
        }
        
        int i = start1 + min(len1, k/2) - 1;
        int j = start2 + min(len2, k/2) - 1;
        if (arr1[i] > arr2[j]) {
            return getKth0(arr1, start1, end1, arr2, j+1, end2, k-(j-start2+1));
        } else {
            return getKth0(arr1, i+1, end1, arr2, start2, end2, k-(i-start1+1));
        }

        
//        return 0;
    }

    
    
    
    // two find serach & traverse
    int twoOfFind(vector<int> arr,int k) {
        
        int start = 0;
        int end = (int)arr.size() - 1;
        int mid = 0;
        while(start <= end) {
            mid = start + (end-start) / 2;
            
            
            // normal
//            if (arr[mid] == k) {
//                return mid;
//            } else if(arr[mid] >= k) {
//                end = mid - 1;
//            } else {
//                start = mid + 1;
//            }
            
            
            // traverse
            /**
             中位数 旋转点 ------目标数
             
             A:旋转点在中位数的右侧，那么中位数左侧为升序，且最左侧元素大于中位数
                如果目标在中位数的左侧，左侧为升序，所以查找条件时 最左侧元素 <= 目标元素 < 中位数
                如果目标在中位数的右侧，
                
             
             B:旋转点在中位数左侧或重合，那么中位数右侧升序，且最左侧元素大于中位数
                如果目标出现在中位数的右侧，右侧为升序，条件为 中位数 < 目标数 <= 最右侧元素
             
             */


//            if (arr[mid] == k) {
//                return mid;
//            }
            // A 旋转点在中位数右侧
//            if (arr[mid] >= arr[start]) {
//
//                // 最左侧元素 <= 目标元素 < 中位数
//                if (arr[mid] > k && k >= arr[start]) {
//                    end = mid - 1;
//                } else {
//                    start = mid + 1;
//                }
//            }
//            // B 旋转点在中位数左侧或者重合
//            else {
//                // 中位数 < 目标 <= 最右侧
//                if (arr[mid] < k && k <= arr[end]) {
//                    start = mid + 1;
//                } else {
//                    end = mid - 1;
//                }
//            }
            

        }
        
    
        return -1;
    }
    
    
    // 01 45 56  return 2
    // 5 5 5 5 5 5 return 01 23 45
    // 相邻两个位置的数之和是偶数
    // 结果不能有重合位置
    
    int evenNumOfArray(vector<int> arr) {
        
        int length = (int)arr.size();
        int sum = 0;
        vector<int> temp;
        for (int i = 1; i < length; i++) {
            sum = arr[i] + arr[i-1];
            if (sum % 2 == 0) {
                temp.push_back(sum);
            }
        }
        
        sum = arr[0] + arr[length-1];
        if (sum % 2 == 0) {
            temp.push_back(sum);
        }
        
        set<int> s1(temp.begin(),temp.end());
        
        return (int)s1.size();
    }

 
    /// 最长回文子序列
    int longestPalindromeSubseq(string s) {
        
        int len = (int)s.length();
        if (len == 0) {
            return 0;
        }
  
        vector<vector<int>> c(len,vector<int>(len));
        
        // i i+1      j-1 j
        // 1 3        4 5
        for (int i = len-1; i>=0; i--) {
            // 单个字符的回文字符串长度为1
            c[i][i] = 1;
            for (int j = i+1; j < len; j++) {
                // 如果i+1 j-1存在最长回文子序列 那么则有
                if (s[i] == s[j]) {
                    c[i][j] = c[i+1][j-1] + 2;
                } else {
                    c[i][j] = max(c[i][j-1], c[i+1][j]);
                }
            }
        }
        
        return c[0][len-1];
    }
    
    /// end
};



int maxNum(vector<int> arr)
{
    
    if(arr.size() < 2) return -1;
    int max = 0;
    int len = (int)arr.size();
    for(int i = len-1;i>=0;i--)
    {
        for(int j = 0;j<i;j++)
        {
            //
           int temp = arr[i] - arr[j];
           if (temp > max) max = temp;
           
        }
     }
    
    return max;
}




int main(int argc, const char * argv[]) {
    // insert code here...
    std::cout << "Hello, World!\n";
    
//    u.f = 3.14159f;
//    printf("As integer: %08x\n", u.i);
    
    
    Solution sol;
//    ListNode *l = sol.initListNode();
//    sol.printOfReverse(l);
    
    
    // 指向指针的指针
//    int val = 4;
//    int *p1 = &val;
//    int **p2 = &p1;
//    
//    cout << p1 << "\n" << endl;
//    cout << p2 << "\n" << endl;
//    int a = 4;
//    retry:
//
//    if (a == 4) {
//        printf("a == 4");
//        goto retry;
//    }
//
//    printf("is end\n");
    
    
    
    int a = 3;
    int *p1 = &a;
    int **p2 = &p1;
    
    printf("**p2 value is %d",**p2);
    
    
    
    // 插入排序
//    vector<int> arr0 = {2,6,9,10};
//    vector<int> arr1 = {1,3,4,0,3,3,3};
//
//    int arr[7] = {1,3,4,0,3,3,3};
    
//    int res = sol.numOccurMoreHalfOfArray(arr1);
//    cout << res;
    
//    sol.quick_sort(arr, 0, 6);
//    display(arr, 7);
    
//    string str = "AABBCCDEF";
//    string pattern = "BCCD";
    
//    int index = sol.boyerMoore(str, pattern);
    
//    int index = sol.kmp0(str, pattern);
//    cout << index << "\n";

//    string str1 = "ABCDABD";
//    vector<int> res = sol.nexts0(str1);
//    printfArray(res);
    
//    bool res = sol.isTwoMi(15);
//    cout << res << "\n";
    
    
//    string s1 = "32";
//    string s2 = "19";
//    string res =  sol.addString0(s1, s2);
//    cout << res << "\n";
    
//    vector<int> arr3 = {4,2,5,8,7,3,7};
//    vector<int> arr3 = {14,21,16,35,22};
//        vector<int> arr3 = {5,5,5,5,5,5};

//    int res = sol.evenNumOfArray(arr3);
//    cout << res << "\n";
//    vector<int> arr4 = {3,4,1,1,2,4,3,1,4};
    
    
    //string s = "bbbab"; // 4
    // cbbd 2 bbbab
//    string s = "bbbab";
//    int res = sol.longestPalindromeSubseq(s);
//    cout << res << "\n";
    
    
//    vector<int> arr = {1,3,5,8,2};
//    int res =  sol.maxProfitKTimes(arr, 2);
//    cout << res << "hh" << "\n";
    

//    vector<int> res = sol.deDeplication(arr4);
//    printfArray(res);
    
//    int array[] = {1,2,3};
//    sol.permutation1(array,0,3);

//    sol.permutation(array, 3, 0);
//    sol.allArrangement(arr4,3);
//    int count = (int)res.size();
//    cout << count << "\n";
    
//    double res = sol.findMiddleNum(arr3, arr4);
//    cout << res << "\n";
    

    
//    vector<vector<int>> twoArr = {{1,3,1},{1,5,1},{4,2,1}};
//    int res = sol.findMinPath1(twoArr);
//    cout << res << "\n";
    
//    sol.insert_sort(arr0);
//    insert_sort(arr0);
//    bubble_sort(arr0);
//    selection_sort(arr0);
//    quick_sort1(arr0, 0, 3);
    
    
//    int n = 15;
//    bool res = sol.isPowerOfTwo2(n);
//    cout << res << "\n";
    
//    int c[] = {0,4,5,9};
//    sol.insertion_sort(c, 4);
    
//    vector<int> arr = {7,1,3,10,5,2,8,9,6};
//    int res = sol.topKthLargest(arr, 3);
//    cout << res << "\n";

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

    
    
//    vector<int> arr11 = {1,3,5,7,10};
//    int index = sol.twoOfFind(arr11, 7);
//    cout<< index << "\n" << endl;

    
    
    
    
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





// k个有序列表合成一个有序链表
struct ZRListNode {
  
    int val;
    ZRListNode *next;
    ZRListNode(int x) : val(x),next(NULL) {};
    
};

ZRListNode *zr_mergeListNode(ZRListNode *node1,ZRListNode *node2) {
    
    ZRListNode *l3 = nullptr;
    if (node1->val < node2->val) {
        l3 = node1;
        l3->next = zr_mergeListNode(l3->next, node2);
    } else {
        l3 = node2;
        l3->next = zr_mergeListNode(node1, l3->next);
    }
    
    return l3;
}

ZRListNode *mergeKthListNode(vector<ZRListNode *> nodes) {
    // 安全判断
    if (nodes.size() <= 0) {
        return nullptr;
    }
    
    // 极限判断
    if (nodes.size() == 1) {
        ZRListNode *head = nodes[0];
        if (!head) {
            return nullptr;
        }
        return head;
    }
    
    // 遍历节点数组
    ZRListNode *resNode = nullptr;
    int j = 0;
    for (int i = 0; i < nodes.size(); i++) {
        j++;
        if (i == (nodes.size() - 1)) {
            resNode->next = nodes[i];
        } else {
            
            ZRListNode *temp = zr_mergeListNode(nodes[i], nodes[j]);
            resNode->next = temp;
        }
    }
    return resNode;
}

















