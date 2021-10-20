# iOS面试知识总结

## 基础

* 分类和扩展有什么区别？可以分别用来做什么？分类有哪些局限性？分类的结构体里面有哪些成员？
* 讲一下atomic的实现机制；为什么不能保证绝对的线程安全（最好可以结合场景来说）？
* 被weak修饰的对象在被释放的时候会发生什么？是如何实现的？知道sideTable么？里面的结构可以画出来么？
* 关联对象有什么应用，系统如何管理关联对象？其被释放的时候需要手动将所有的关联对象的指针置空么？
* KVO的底层实现？如何取消系统默认的KVO并手动触发（给KVO的触发设定条件：改变的值符合某个条件时再触发KVO）？
* `Autoreleasepool`所使用的数据结构是什么？`AutoreleasePoolPage`结构体了解么？
* 讲一下对象，类对象，元类，跟元类结构体的组成以及他们是如何相关联的？为什么对象方法没有保存的对象结构体里，而是保存在类对象的结构体里？
* `class_ro_t` 和 `class_rw_t` 的区别？
* iOS 中内省的几个方法？`class`方法和`objc_getClass`方法有什么区别?
* 在运行时创建类的方法`objc_allocateClassPair`的方法名尾部为什么是pair（成对的意思）？
* 一个int变量被`__block`修饰与否的区别？
* 为什么在block外部使用`__weak`修饰的同时需要在内部使用`__strong`修饰？
* RunLoop的作用是什么？它的内部工作机制了解么？（最好结合线程和内存管理来说）
* 哪些场景可以触发离屏渲染？（知道多少说多少）

## 网络

* App 网络层有哪些优化策略？
* TCP为什么要三次握手，四次挥手？
* 对称加密和非对称加密的区别？分别有哪些算法的实现？
* HTTPS的握手流程？为什么密钥的传递需要使用非对称加密？双向认证了解么？
* HTTPS是如何实现验证身份和验证完整性的？
* 如何用Charles抓HTTPS的包？其中原理和流程是什么？
* 什么是中间人攻击？如何避免？

## 实战

* AppDelegate如何瘦身？
* 反射是什么？可以举出几个应用场景么？（知道多少说多少）
* 有哪些场景是NSOperation比GCD更容易实现的？（或是NSOperation优于GCD的几点，知道多少说多少）
* App 启动优化策略？最好结合启动流程来说（main()函数的执行前后都分别说一下，知道多少说多少）
* App 无痕埋点的思路了解么？你认为理想的无痕埋点系统应该具备哪些特点？（知道多少说多少）
* 你知道有哪些情况会导致app崩溃，分别可以用什么方法拦截并化解？（知道多少说多少）
* 你知道有哪些情况会导致app卡顿，分别可以用什么方法来避免？（知道多少说多少）

## 计算机系统

* 了解编译的过程么？分为哪几个步骤？
* 静态链接了解么？静态库和动态库的区别？
* 内存的几大区域，各自的职能分别是什么？
* static和const有什么区别？
* 了解内联函数么？
* 什么时候会出现死锁？如何避免？
* 说一说你对线程安全的理解？
* 列举你知道的线程同步策略？
* 有哪几种锁？各自的原理？它们之间的区别是什么？最好可以结合使用场景来说

## 设计模式

* 除了单例，观察者设计模式以外，还知道哪些设计模式？分别介绍一下
* 最喜欢哪个设计模式？为什么？
* iOS SDK 里面有哪些设计模式的实践？
* **设计模式是为了解决什么问题的？
* **设计模式的成员构成以及工作机制是什么？
* **设计模式的优缺点是什么？

## 架构 & 设计

* MVC和MVVM的区别？MVVM和MVP的区别？
* 面向对象的几个设计原则了解么？最好可以结合场景来说。
* 可以说几个重构的技巧么？你觉得重构适合什么时候来做？
* 你觉得框架和设计模式的区别是什么？
* 看过哪些第三方框架的源码，它们是怎么设计的？设计好的地方在哪里，不好的地方在哪里，如何改进？（这道题的后三个问题的难度已经很高了，如果不是太N的公司不建议深究）

## 数据机构&算法

* ## 1.数学实现

  ### 1.1 斐波那契数列

  ```c++
  int fib(int x) {
  	int res[] = [0,1];
  	if(x < 1) {
  		return res[x];
  	}
  	int fib1 = 1;
  	int fib2 = 0;
  	int fibn = 0;
  	for(int i = 2;i < x;i++) {
  		fibn = fib1 + fib2;
  		fib2 = fib1;
  		fib1 = fibn
  	}
  	return fibn;
  }
  
  ```

  ### 1.2 二分查找与旋转二分查找

  ```c++
  int binarySearch(vector<int> arr,int goal) {
  	int high = arr.size() - 1;
  	int low = 0;
  	
  	while (low <= high) {
  		int mid = low + (high - low) / 2;
  		if (arr[mid] == goal) {
  			return mid;
  		} else if (arr[mid] > goal) {
  			high = mid - 1;
  		} else {
  			low = mid + 1;
  		}
  	}	
  	
  	return -1;
  }
  
  /*
  旋转数组二分查找
  */
  
  int rotateBinarySearch(vector<int> arr,int goal) {
  	int high = (int)arr.size() - 1;
  	int low = 0;
  	while (low <= high) {
  		int mid = low + (high - low) / 2;
  		if (arr[mid] == goal) {
  			return mid;
  		}
  		// low <= goal < mid
  		if (arr[low] < arr[mid]) {
  			if (arr[low] <= goal && goal < arr[mid]) {
  				high = mid - 1;
  			} else {
  				low = mid + 1;
  			}
  		} else {
  			// mid < goal <= high
  			if (arr[min] < goal && goal <= arr[high]) {
  				low = mid + 1;
  			} else {
  				high = mid - 1;
  			}
  		}
  	}
  	
  	return -1;
  }
  
  
  ```

  ### 1.3 是否是2的幂

  ```c++
      bool isPowerOfTwo(int n) {
          
          if (n == 1) {
              return true;
          }
          if (n == 0) {
              return false;
          }
          return (n & (n-1)) == 0;
      }
  ```

  ## 2.算法实现

  ### 2.0 冒泡 最坏==平均n*n 空间O(1) 稳定

  ```c++
      void bubbleSort(vector<int> arr) {
          for (int i = 0; i < arr.size() - 1; i++) {
              for (int j = 0; j < arr.size() - 1 - i; j++) {
                  if (arr[j] > arr[j+1]) {
                      std::__1::swap(arr[j], arr[j+1]);
                  }
              }
          }
      }
  
  ```

  ### 2.1 插入  最坏==平均n*n 空间O(1) 稳定

  ```c++
      void insertSort(vector<int> arr) {
          for (int i = 1; i < arr.size(); i++) {
              int j = i -1;
              int k = arr[i];
              while (j >= 0 && k < arr[i]) {
                  arr[j+1] = arr[j];
              }
              arr[j+1] = k;
          }
      }
  ```

  ### 2.2 选择 最坏==平均n*n 空间O(1) 不稳定

  ```C++
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
  ```

  ### 2.3 快速 最坏n*n,平均O(nlogn) 空间O(logn) 不稳定

  ```C++
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
  ```

  ### 2.6 归并 O(n) nlogn 空间O(n) 稳定

  ```c++
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
  ```


  ## 3.链表

  ```c++
  struct ListNode{
  	int val;
  	ListNode *next;
  	ListNode(int x) : val(x),next(NULL) {};
  }
  ```

  ### 3.0 链表是否有环

  ```c++
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
  
  ```

  ### 3.1 两个链表的交点

  ```c++
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
  ```

  ### 3.2 反转链表

  ```c++
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
  
  ```

  ### 3.3 合并两个链表

  ```
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
  
  ```

  ### 3.4 找出链表的倒数k个节点并删除

  ```c++
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
  
  ```

  ### 3.5 倒序打印链表

  ```
      void printOfReverse(ListNode *root) {
          
          if (root) {
             
              if (root->next) {
                  printOfReverse(root->next);
              }
              cout << "the node is: " << root->val << "\n";
          }
      }
  
  ```

  ### 3.6 删除链表里的某个节点

  ```C++
      void delNode(ListNode *head) {
          if (!head || !head->next) {
              return;
          }
          
          head->val = head->next->val;
          head->next = head->next->next;
          
      }
  
  ```

  ### 3.7 删除链表内重复的节点，保留单个节点

  ```C++
      void removeDuplicateNodes(ListNode *head) {
          
          if (!head) {
              return;
          }
          ListNode *cur = head;
          while (cur->next) {
              if (cur->val == cur->next->val) {
                  ListNode *delNo = cur->next;
                  cur = delNo->next
                  delNode(delNo);
              } else {
                  cur = cur->next;
              }
          }
      }
  
  ```

  ### 3.8 删除链表里某个值的所有节点

  ```c++
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
  
  ```

  ### 3.9 左右临界值分离

  ```c++
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
  
  ```

  ### 3.10 左右奇偶index的值分离

  ```c++
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
  ```

  ## 4.数组

  ### 4.0 检测数组中是否包含重复的元素

  ```c++
   bool hasDuplicateItems(vector<int> arr) {
          set<int> s1(arr.begin(),arr.end());
          return s1.size() != arr.size();
   }
  ```

  ### 4.1 出现次数超过数组长度一半的元素

  ```c++
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
  ```

  ### 4.2 数组中只出现过一次的数字

  ```c++
      int onceNum(vector<int> arr) {
          int res = -1;
          for (int i = 0; i < arr.size(); i++) {
              res ^= arr[i];
          }
          return res;
      }
  ```

  ### 4.3 寻找数组中缺失的数字

  ```c++
      int missNum(vector<int> arr) {
          int res = -1;
          int i = 0;
          for (i = 0; i < arr.size(); i++) {
              res = arr[i] ^ i ^ res;
          }
          return res ^ i;
      }
  ```

  ### 4.4 将所有的0移动到数组末尾

  ```c++
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
  ```

  ### 4.5 移除数组中等于某个值的元素,返回数组长度

  ```c++
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
  ```

  ### 4.6 无序数组和大于或等于某值的最小子数组

  ```c++
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
  ```

  ### 4.7 两个数组的交点元素

  ```c++
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
  ```

  ### 4.8 出现频率最高的第k个元素

  ```c++
      vector<int> topKFrequent(vector<int> arr,int k) {
          unordered_map<int, int> m;
          priority_queue<pair<int, int>> q;        
          vector<int> res;
          // 把元素作为key进行赋值map
          for (auto a : arr) {
              ++m[a];
          }
          
          // map的遍历器
          for (auto it : m) {
              // second: 出现的频次
              // first: 元素
              q.push({it.second,it.first});
          }
          
          for (int i = 0; i < k; i++) {
              res.push_back(q.top().second);
              q.pop();
          }
          
          
          return res;
      }
  ```

  ### 4.9 数组中第k大的元素

  ```c++
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
  ```

  ### 4.9 合并两个有序的数组

  ```c++
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
  
  ```

  ### 4.10 两个元素的和为目标值

  ```c++
  /// 有序
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
      
      
  /// 无序
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
  ```

  ### 4.11 求两个有序数组的中位数(二分查找)

  ```C++
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
  ```

  ### 4.12 数组全排列

  ```c++
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
  
  ```

  ### 4.13 数组去重

  ```c++
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
  ```

  ### 4.14 二维矩阵的最小路径

  ```c++
      int findMinPath(vector<vector<int>>& arr) {
          
          
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
  ```

  ### 4.15 股票最大收益 k次买入卖出

  ```c++
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
  ```

  


  ## 5.二叉树

  ```c++
  struct GTreeNode {
  
  	int val;
  	GTreeNode *left;
  	GTreeNode *right;
  	GTreeNode(int x) : val(x),left(NULL),right(NULL){};
  }
  ```

  ### 5.0 遍历树

  ```c++
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
  
  ```

  ### 5.1 二叉树的最近公共祖先

  ```c++
      TreeNode *lowestCommonAncestor1(TreeNode *root,TreeNode *p,TreeNode *q) {
          if (!root || p == root || q == root) {
              return root;
          }
          
          TreeNode *lnode = lowestCommonAncestor1(root->left, p, q);
          TreeNode *rnode = lowestCommonAncestor1(root->right, p, q);
          if (lnode && rnode) {
              return root;
          }
          
          return lnode ? lnode : rnode;
      }
  
  ```

  ### 5.2 多叉树的最近公共祖先

  ```c++
      struct TNode {
          int id;
          vector<TNode *> members;
      };
   
      vector<TNode *> findAllNode(TNode *root,TNode *k,vector<TNode *> res) {
          
          if (!root || k == root) {
              res.push_back(root);
              return res;
          }
          res.push_back(root);
          vector<TNode *> members = root->members;
          
          for (int i = 0;i < members.size();i++) {
             findAllNode(members[i], k,res);
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
          vector<TNode *> res1;
          vector<TNode *> res2;
          findAllNode(root, p,res1);
          findAllNode(root, q,res2);
          
          // 求1和2的交点
          set<TNode *> s1(res1.begin(),res1.end());
          for (auto it = res2.rbegin(); it != res2.rend(); ++it) {
              if (s1.find(*it) != s1.end()) {
                  return *it;
              }
          }
          
          return nullptr;
      }
  
  ```

  ## 6.字符串

  ### 6.0 最长公共子序列

  ```c++
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
  
  ```

  ### 6.1 字符串搜索KMP

  ```c++
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
  
  ```

  ### 6.2 最长回文子序列

  ```c++
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
  
  ```

  ### 6.3 字符串解码

  ```c++
  /// String decode
  /// Time T(O) = O(N)
  /// Space T(O) = O(N)
  
  string decodeString(string s) {
  
      // init stack for save res and num
      stack<pair<int, string>> stackT;
      int num = 0;string res = "";
      for (int i = 0; i < s.size(); i++) {
          // if item is num to save stack
          if (s[i] >= '0' && s[i] <= '9') {
              num *= 10;
              num += (s[i] - '0');
          } else if (s[i] == '['){ // meet [ push num and res then res = "" and num = 0
              stackT.push(make_pair(num, res));
              num = 0;
              res = "";
              
          } else if(s[i] == ']') {// meet ] pop num and res then append string
              int repeatTimes = stackT.top().first; // tempNum is need repeat times
              string a = stackT.top().second; //
              stackT.pop();
              for (int i = 0; i < repeatTimes; i++) {
                  a = a + res;
              }
              res = a;
          } else { // meet character a-z
              res += s[i];
          }
      }
      
      return res;
  }
  ```

  

## 备注

* [答案版本0](https://juejin.cn/post/6844904030750130183)
