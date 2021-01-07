//
//  SingleList.c
//  1129Algorithm
//
//  Created by Augus on 2020/11/29.
//

#include "SingleList.h"

int first = 0,end = 0;

typedef struct ListNode {
    int data;
    struct ListNode *next;
}ListNode;

// 反转列表-非递归
ListNode* reverseList0(ListNode *head)
{
    
    // 当前节点
    ListNode *curr = head;
    // 只有一个节点
    if (curr == NULL) {
        return NULL;
    }
    // 定义上一个节点以及临时节点
    ListNode *pre = NULL,*temp = NULL;
   
    /*
     1    2   3   4   5
     第一次循环：
     temp指向了节点2，将节点2保存起来
     将pre赋值给了curr->next,节点1指向了NULL
     将head赋值给了pre，即pre指向了节点1，将节点1设置为上一个节点
     head指向了节点2，将节点2设为头节点
     
     
     
     **/
    while (curr != NULL) {
        temp = curr->next;//
        curr->next = pre;//
        pre = curr;//
        curr = temp;//
    }
    // 当前节点
    return pre;
    
}


// 反转列表-递归
ListNode* reverseList1(ListNode *head)
{
    if (head == NULL || head->next == NULL) {
        return head;
    }
    
    ListNode *p = reverseList1(head->next);
    head->next->next = head;
    head->next = NULL;
    return p;
    
}

typedef struct BTreeNode{
    int data;
    struct BTreeNode *lchild;
    struct BTreeNode *rchild;
}BTreeNode,*TreeNode;



//BTreeNode *InitBinTree(BTreeNode *T){
//
//    T = (BTreeNode *)malloc(sizeof(BTreeNode));
//    return T;
//}

BTreeNode * CreateBTreeNode(BTreeNode *T)
{

    // 1 2层节点构造完毕
//    T = (BTreeNode *)malloc(sizeof(BTreeNode));
//    T->data = 'a';
//    T->lchild = (BTreeNode *)malloc(sizeof(BTreeNode));
//    T->lchild->data = 'b';
//    T->rchild = (BTreeNode *)malloc(sizeof(BTreeNode));
//    T->rchild->data = 'c';
    /// ...
//    T->lchild->lchild = (BTreeNode *)malloc(sizeof(BTreeNode));
//    T->lchild->lchild->data = 'd';
//    T->lchild->rchild = (BTreeNode *)malloc(sizeof(BTreeNode));
//    T->lchild->rchild->data = 'e';
//    T->lchild->rchild->lchild = NULL;
//    T->lchild->rchild->rchild = NULL;
//
//    T->lchild->lchild->lchild = (BTreeNode *)malloc(sizeof(BTreeNode));
//    T->lchild->lchild->lchild->data = 'h';
//    T->lchild->lchild->lchild->lchild = NULL;
//    T->lchild->lchild->lchild->rchild = NULL;
//
//    T->lchild->lchild->rchild = (BTreeNode *)malloc(sizeof(BTreeNode));
//    T->lchild->lchild->rchild->data = 'i';
//    T->lchild->lchild->rchild->lchild = NULL;
//    T->lchild->lchild->rchild->rchild = NULL
//
//    T->rchild->lchild = (BTreeNode *)malloc(sizeof(BTreeNode));
//    T->rchild->lchild->data = 'f';
//    T->rchild->lchild->lchild = NULL;
//    T->rchild->lchild->rchild = NULL;
//
//    T->rchild->rchild = (BTreeNode *)malloc(sizeof(BTreeNode));
//    T->rchild->rchild->data = 'g';
//    T->rchild->rchild->lchild = NULL;
//    T->rchild->rchild->rchild = NULL;
    
    return T;
}

// 入队
void InQueue(BTreeNode **queue,BTreeNode *elem)
{
    queue[end++] = elem;
}

// 出队
BTreeNode *OutQueue(BTreeNode **queue){
    return queue[first++];
}


// 打印
void BTreePrint(BTreeNode *elem){
    printf("%c",elem->data);
}

// 层级遍历
void LevelPrintBTreeNode(BTreeNode *T)
{
    BTreeNode *t;
    TreeNode queue[20]; // 定义队列
    InQueue(queue, T); // 初始化 根节点入队
    while (first < end) { // 队列不为空
        t = OutQueue(queue);
        BTreePrint(t);
        // 将出队的节点左右孩子依次入队
        if (t->lchild) {
            InQueue(queue, t->lchild);
        }
        if (T->rchild) {
            InQueue(queue, t->rchild);

        }
    }
}

/*
 
typedef struct ListNode {
    int data;
    struct Listnode *next;
 }ListNode;
 
 
 ListNode* reverseList(ListNode *head)
 {
 
        ListNode *curr = head;
        if(curr == NULL){
            return NULL;
        }
 
        ListNode *temp = NULL,*pre = NULL;
        while(curr){
            temp = curr->next;
            curr->next = pre;
            pre = curr;
            curr = temp;
        }
 
        return pre;
 }
 
 1.osi 网络模型
 
 应用层 网络与应用之间接口连接
 表示层 格式化表示和数据转换服务，比如压缩和加密
 会话层 提供访问和会话管理在内的建立和维护应用之间的通信机制
 
 传输层 建立 维护 取消 连接传输功能，负责可靠的传输数据
 网络层 处理网络路由 确保数据实时传送
 
 数据链路层 负责无措传输数据 确认帧 发错重传等
 物理层 提供机械 电气 功能过程特性
 
 
 
 
 反转链表
 
 typedef struct ListNode {
 
        int data;
        struct ListNode *next;
 }ListNode;
 
 ListNode* reverseList(ListNode *head)
 {
    ListNode *curr = head;
    if(curr == NULL){
        return NULL;
    }
 
    ListNode *pre = NULL,*temp = NULL;
    while(curr){
        temp = curr->next;
        curr->next = pre;
        pre = head;
        head = temp;
    }
 
    return pre;
 }
 
 // 判断单链表有环
 bool hasCycle(ListNode *head)
 {
     if (head == NULL) {
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
     
     return  false;
 }
 
 
 
 
 
 哈希函数 == 散列函数
 
 它对不同的输出值得到一个固定长度的消息摘要，理想的哈希函数对于不同的输入应该产生不同的结构
 同时散列结果应当具有同一性（输出值尽量均匀）和雪崩效应（微小的输入值变化使得输出值发生巨大变化）
 
 冲突解决
 
开放定址法，链地址法，建立公共溢出区等
 
 
 
 
 1. 单链表反转
 
 typedef struct ListNode {
 
 
        int data; // data area
        ListNode *next; // pointer area
 
 } ListNode;
 
 ListNode* reverseList(ListNode *head)
 {
        if head == NULL return NULL;
        ListNode *curr = head;
        ListNode *pre = NULL,*temp = NULL;
        while(curr){
 
            temp = curr->next;
            curr->next = pre;
            pre = curr;
            curr = temp;
        }
        return pre;
 }
 
 // has cycle signle listnode
 
 
 bool hasCycle(ListNode *head)
 {
 
        if head == NULL return false;
        ListNode *slow = head;
        ListNode *fast = head->next;
        while(fast && fast->next)
        {
            slow = slow->next;
            fast = fast->next-next;
            if(slow == fast){
                return true;
            }
        
        }
 }
 
 // find input node
 
 if(slow == fast){
    ListNode *slow1 = head;
    while(slow1 != slow){
        slow = slow->next;
        slow1 = slow->next->next;
    }
    return slow1;
 }
 
 
 // double list find
 
 ListNode* getSectionNode(ListNode *head1,ListNode *head2)
 {
        if head1 == NULL || head2 == NULL return NULL;
        ListNode *p1 = head1;
        ListNode *p2 = head2;
        
        while(p1 != p2){
 
        p1 = p1 != NULL ? p1->next : head2;
        p2 = p2 != NULL ? p2->next : head1;
        }
 
        return p1;
 }
 
 // sigle list for finding middle node
 
 ListNode* findMiddleNode(ListNode *head)
 {
        if head == NULL return NULL;
        ListNode *slow = head;
        ListNode *fast = head->next;
        while(fast && fast->next){
            slow = slow->next;
            fast = fast->next->next;
        }
        return slow;
 }
 
 
 // fast
 
 void QuickSort(int *arr,int begin,int end)
 {
        int i = begin;
        int j = end;
        int k = arr[i];
 
        while(i < j){
        
        while(i < j && arr[j] >= k){ // left
            j--;
        }
        if(i < j){
            arr[i++] = arr[j];
        }
 
        while(i < j && arr[j] < k){// right
            i++;
        }
        if(i < j){
            arr[j--] = arr[i];
        }
 
 }
 
        arr[i] = k;
 
        // Sort
        QuickSort(arr,i,i-1);
        QuickSort(arr,i+1,j);
 
 
 }
 
 /// 层次遍历二叉树
 
 typedef struct BTree{
 
    char data,
    struct BTree *lchild,
    struct BTree *rchild
 
 }BTree;
 
 

 // 股票问题 最大利润
 
 int max(int num1,int num2){
  
  int res = num1 - num2;
  if res > 0{
     return num1;
  }else{
     return num2;
  }
  }
  
 int min(int num1,int num2){
  
  int res = num1 - num2;
  if res < 0 {
     return num1;
  }else{
     return num2;
  }
  }
 
int maxProfit(int *arr){
 
    if (arr.lengt == 0 || arr == NULL ) return 0;
    int soFarMin = num[0];
    int maxProfit = 0;
    for(int i = 1;i < arr.lengt;i++){
        soFarMin = min(soFarMin,num[i]);
        maxProfit = max(maxProfit,num[i] - soFarMin);
    }
    return maxProfit;
 }
 


//二叉树的最近公共祖先 递归解法
TreeNode *postSearch(TreeNode *root, TreeNode *p,TreeNode *q) {
     struct TreeNode *lnode = NULL, *rnode = NULL;
     if(root->left) {
         lnode = postSearch(root->left, p, q);
     }
     if(root->right) {
         rnode = postSearch(root->right, p, q);
     }
     if(root == p || root == q) {
         return root;
     }
     if(lnode && rnode )
         return root;
     else
         return lnode ? lnode : rnode;
 }
  
TreeNode *lowestCommonAncestor(TreeNode *root, TreeNode *p, TreeNode *q) {
     return postSearch(root, p, q);
}
 
 
 // reverse string
 
 void sawp(char *a,char *b)
 {
    char t = *a;
    *a = *b; *b = t;
 
 }
 
 void reverseString(char *s,int length)
 {
    for (int left = 0,right = lenght - 1;left < right;++left;--right){
        swap(s + left,s + right)
    }
 }
 
 复杂度分析

 时间复杂度：O(N)，其中 N 为字符数组的长度。一共执行了 N/2 次的交换。
 空间复杂度：O(1)只使用了常数空间来存放若干变量。


 
 
 时间维度：是指执行当前算法所消耗的时间，我们通常用「时间复杂度」来描述。
 空间维度：是指执行当前算法需要占用多少内存空间，我们通常用「空间复杂度」来描述。

 并不是用来计算具体时间的，因为不同的设备跑同样的程序就会得到不同的结果，只是一个大概的粗略描述
 
 贪心算法：
 1.孩子饥饿分饼干，最多有多少个孩子可以喂饱
 
 思路：
 1.孩子饥饿排序
 2.饼干大小排序
 3.循环
 int child = 0
 int cookie = 0
 while(child < children.size() && cookie < cookies.size())
 {
    children[child] <= cookies[cookie];
    child++;
    cookie++;
 }
 
 return child;
 
 
 
 
 2.孩子按成绩分糖，最少需要多少个糖果
 思路：
 先每个孩子发一个糖
 
 1 1 1
 
 然后从左往右遍历，如果右侧大于左侧的评分，就给右侧+1糖
 然后从右往左遍历，如果左侧大于右侧且左侧的目前的糖果不大于右侧，则给左侧+1糖
 
 int candy(int *arr)
 {
    int size = candy.size();
    if size < 2 return size;
    int num[size];
    // left->right
    for(int i = 0;i < size;i++){
        if(arr[i] > arr[i-1]){
            num[i] = num[i] + 1;
        }
    }
 
 for(int i = size;i > 0;i--){
     
         if(arr[i-1] > arr[i]){
         num[i -1] = max(num[i-1],num[i]+1)
       }
    }
 
 return sum(num);
 }
 
 
 3 区间问题
   给定多个区间，计算这些互不重叠所需要移除区间的最小个数，起止相连不算重叠
 
    input:[[1,2],[2,4],[1,3]]
    output:1
 
 
 
 int eraseOverlapIntervals(vector<vector<int>>& intervals)
 {
    if (intervals.empty()) {
        return 0;
    }
    int n = intervals.size();
    sort(intervals.begin(),intervals.end(),[]vector<int> a,vector<int> b){
        return a[1] < b[1];
    }

    int total = 0,prev = intervals[0][1];
    for(int i = 1;i < n;i++){
        if(intervals[1][0] < prev){
            ++total;
        }else {
            prev = intervals[i][1];
        }
    }
    return total;
 }
 
 
 4 双指针
 指针与常量
 int x;
 int * p = &x
 const int * p2 = &x
 int * const p3 = &x
 const int * const p4 = &x
 
 在一个增序的整数数组里找到两个数，使它们的和为给定值。已知有且只有一对解。
 Input: numbers = [2,7,11,15], target = 9
 Output: [1,2]
 
 vector[int] twoSum(vector<int>& numbers,int target)
 {
        int l = 0,r=numbers.size() - 1,sum;
        while(l < r){
            sum = numbers[l] + numbers[r];
            if(sum == target) break;
            if(sum < target) ++l;
            else --r;
        }
        return vector[int]{l+1,r+1};
 }
 
 
 
 5归并两个有序数组
 
 Input: nums1 = [1,2,3,0,0,0], m = 3, nums2 = [2,5,6], n = 3
 Output: nums1 = [1,2,2,3,5,6]
 
 TODO: a++,++a
 a++ 和 ++a 都是将 a 加 1，
 但是 a++ 返回值为 a，
 而 ++a 返回值为 a+1。
 如果只是希望增加 a 的值，而不需要返回值，
 则推荐使用 ++a，其运行速度 会略快一些。
 
 因为++k运算结束后，k的值和表达式的值相同而k++运算结束后，k的值和表达式的值不相同。
 编译器要开辟一个新的变量来保存k++表达式的值。 所以说：++k更快。
 
 void merge(vector<int>& nums1,int m,vector<int>& nums2,int n)
 {
    int pos = m-- + n-- - 1;
    while(m >= 0&& n >= 0){
        nums1[pos--] = nums1[m] > nums2[n]? nums1[m--]:nums2[n--];
    }
    while(n >= 0){
        nums1[pos--] = num2[n--];
    }
 
 }
 
 6 最近的公共父节点
 
 两个节点 p,q 分为两种情况：

 p 和 q 在相同子树中
 p 和 q 在不同子树中
 从根节点遍历，递归向左右子树查询节点信息
 递归终止条件：如果当前节点为空或等于 p 或 q，则返回当前节点

 递归遍历左右子树，如果左右子树查到节点都不为空，则表明 p 和 q 分别在左右子树中，因此，当前节点即为最近公共祖先；
 如果左右子树其中一个不为空，则返回非空节点。

 
 TreeNode * lowCommonAncestor(TreeNode *root,TreeNode *p,TreeNode *q)
 {
    if(!root || !p || !q) return root;
    TreeNode *left = lowCommonAncestor(root->left,p,q);
    TreeNode *right = lowCommonAncestor(root->right,p,q);
    if(left && right) return root;
    return left ? left : right;

 }
 
 
 
 **/


