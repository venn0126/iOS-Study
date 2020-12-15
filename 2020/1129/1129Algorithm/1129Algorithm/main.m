//
//  main.m
//  1129Algorithm
//
//  Created by Augus on 2020/11/29.
//

#import <Foundation/Foundation.h>
#include "SingleList.h"


#define BUF_SIZE 10
#define MAXSIZE 20

#define ElementType int

//初始化队头和队尾指针
int front = 0, rear = 0;

/// 结构体声明

struct Books {
    char title[50];
    char author[50];
    char subject[100];
    int book_id;
    
}book,VBook;

typedef struct ListNode {
    int data;//数据域
    struct ListNode *next;// 指针域
}ListNode;

/*  about tree struct */

typedef struct BinTNode{
    ElementType data;
    struct BinTNode *left;
    struct BinTNode *right;
}BinTNode, *BinTree;



/// 方法

ListNode* reverseList(ListNode* head) {
    // 上一个节点
    ListNode* prev = NULL;
    // 当前节点
    ListNode* current = head;
    // 循环直到当前节点为NULL代表链接最后一个节点结束
    while (current) {
        struct ListNode* node = current->next;
        current->next = prev;
        prev = current;
        current = node;
    }

    return prev;
}

// 字符串反转
void char_reverse(char * cha) {
    // 指向第一个字符
    char * begin = cha;

    // 指向字符串末尾
    char * end = cha + strlen(cha) - 1;

    while (begin < end) {
        // 交换字符，同时移动指针
        char temp = *begin;
        *(begin++) = *end;
        *(end--) = temp;
    }
}

/**************************************************
 *函数名：display
 *作用：打印数组元素
 *参数：array - 打印的数组，maxlen - 数组元素个数
 *返回值：无
 **************************************************/
void display(int array[], int maxlen)
{
    int i;
 
    for(i = 0; i < maxlen; i++)
    {
        printf("%-3d", array[i]);
    }
    printf("\n");
 
    return ;
}

/************************************
 *函数名：QuickSort
 *作用：快速排序算法
 *参数：
 *返回值：无
 ************************************/
void QuickSort(int *arr, int low, int high)
{
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
        QuickSort(arr, low, i - 1);     // 排序k左边
        QuickSort(arr, i + 1, high);    // 排序k右边
    }
}

// 层序遍历
// 创建二叉树


BinTNode *InitBinTree(BinTNode *T){
    
    T = malloc(sizeof(BinTNode));
    return T;
}

BinTNode * CreateBinTree(BinTNode *T) {
    T=(BinTNode*)malloc(sizeof(BinTNode));
    T->data='A';
    T->left=(BinTNode*)malloc(sizeof(BinTNode));
    T->left->data='B';
    T->right=(BinTNode*)malloc(sizeof(BinTNode));
    T->right->data='C';
  
    T->left->left=(BinTNode*)malloc(sizeof(BinTNode));
    T->left->left->data='D';
    T->left->right=(BinTNode*)malloc(sizeof(BinTNode));
    T->left->right->data='E';
    T->left->right->left=NULL;
    T->left->right->right=NULL;
    T->left->left->left=(BinTNode*)malloc(sizeof(BinTNode));
    T->left->left->left->data='H';
    T->left->left->left->left=NULL;
    T->left->left->left->right=NULL;
    T->left->left->right=(BinTNode*)malloc(sizeof(BinTNode));
    T->left->left->right->data='I';
    T->left->left->right->left=NULL;
    T->left->left->right->right=NULL;
      
    T->right->left=(BinTNode*)malloc(sizeof(BinTNode));
    T->right->left->data='F';
    T->right->left->left=NULL;
    T->right->left->right=NULL;
    
    T->right->right=(BinTNode*)malloc(sizeof(BinTNode));
    T->right->right->data='G';
    T->right->right->left=NULL;
    T->right->right->right=NULL;

    return T;
}

//入队
void EnQueue(BinTNode ** queue,BinTNode * elem) {
    queue[rear++] = elem;
}

//出队
BinTNode* DeQueue(BinTNode** queue) {
    return queue[front++];
}

//输出
void printElement(BinTNode * elem) {
    printf("%c ",elem->data);
}

// 层级遍历
void levelOrderTraverse(BinTNode * tree) {
    BinTNode * T;
    BinTree queue[20];      // 定义队列
    
    EnQueue(queue, tree);   // 初始化，根结点入队
    while(front < rear) {   // 队列不为空
        T = DeQueue(queue);     // 结点出队
        printElement(T);
        // 将出队的结点左右孩子依次入队
        if (T->left!= NULL) {
            EnQueue(queue, T->left);
        }
        if (T->right!= NULL) {
            EnQueue(queue, T->right);
        }
    }
}


/// 测试入口
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
//        int array[BUF_SIZE] = {12,85,25,16,34,23,49,95,17,61};
//        int maxlen = BUF_SIZE;
//
//        printf("排序前的数组\n");
//        display(array, maxlen);
//
//        QuickSort(array, 0, maxlen-1);  // 快速排序
////        QSort(array, 0, maxlen-1);
//
//        printf("排序后的数组\n");
//        display(array, maxlen);
        
        BinTNode *tree = NULL;
        tree = CreateBinTree(tree);
        printf("层次遍历: ");
        levelOrderTraverse(tree);
        printf("\n");
        
        
        
    }
    return 0;
}




/// 自我测试


