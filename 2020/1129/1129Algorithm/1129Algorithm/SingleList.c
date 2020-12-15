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
 
 **/
