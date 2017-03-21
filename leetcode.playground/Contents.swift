//: Playground - noun: a place where people can play

import UIKit

// 541. Reverse String II
func reverseString(_ s: String, _ k: Int) -> String {
    var chars = s.characters
    var result = ""
    while k <= chars.count {
        var kString = [Character]()
        for _ in 1...k {
            kString.append(chars.popFirst()!)
        }
        result += String(kString.reversed())
        
        for _ in 1...k {
            if let popChar = chars.popFirst() {
                result.append(popChar)
            }
        }
    }
    result += String(chars.reversed())
    return result
}

var reverseTestString = "abcdefg"
reverseString(reverseTestString,2)

// 539. Minimum Time Difference
func findMinDifference(_ timePoints: [String]) -> Int {
    var resultBool = [Bool](repeating: false, count:1440*2)
    for time in timePoints {
        let ints = time.components(separatedBy: ":")
        let index = Int(ints[0])!*60+Int(ints[1])!
        if resultBool[index] {return 0}
        resultBool[index] = true
        resultBool[index+1440] = true
    }
    var min = 1440
    var previous = -100000
    for i in 0..<resultBool.count {
        if resultBool[i] {
            min = i-previous > min ? min : i-previous
            previous = i
        }
    }
    return min
}

findMinDifference(["05:31","22:08","00:35"])

// 409. Longest Palindrome
func longestPalindrome(_ s: String) -> Int {
    guard s != "" else {
        return 0
    }
    var count = 0
    var charSet : Set<Character> = []
    for c in s.characters {
        let result = charSet.insert(c)
        if result.inserted == false {
            charSet.remove(result.memberAfterInsert)
            count += 1
        }
    }
    return charSet.isEmpty ? count*2 : count*2+1
}

longestPalindrome("abccccbd")

// 53. Maximum Subarray
func maxSubArray(_ n: [Int]) -> Int {
    var nums = n
    var best = nums[0];
    var current = nums[0];
    
    for i in 1..<nums.count {
        current = max(current + nums[i], nums[i]);
        best = max(current, best);
    }
    return best;
}

maxSubArray([-2,1,-3,4,-1,2,1,-5,4])

// 461. Hamming Distance
func hammingDistance(_ x: Int, _ y: Int) -> Int {
    let xor = x ^ y
    let str = String(xor,radix:2)
    var count = 0
    for s in str.characters {
        if s == "1" {
            count += 1
        }
    }
    return count
}

hammingDistance(1, 4)

// 476. Number Complement
func findComplement(_ num: Int) -> Int {
    var i=1
    while i<=num {
        i = i<<1
    }
    return num ^ (i-1)
}

findComplement(1)

// 500. Keyboard Row
func findWords(_ words: [String]) -> [String] {
    let qwer = Set<Character>(arrayLiteral: "q","w","e","r","t","y","u","i","o","p")
    let asdf = Set<Character>(arrayLiteral: "a","s","d","f","g","h","j","k","l")
    let zxcv = Set<Character>(arrayLiteral: "z","x","c","v","b","n","m")
    var result = [String]()
    for word in words {
        let lowcaseWord = word.lowercased()
        let wordSet = Set<Character>(lowcaseWord.characters)
        if wordSet.isSubset(of: qwer) || wordSet.isSubset(of: asdf) || wordSet.isSubset(of: zxcv) {
            result.append(word)
        }
    }
    return result
}

findWords(["Hello", "Alaska", "Dad", "Peace"])

// 412 Fizz Buzz
func fizzBuzz(_ n: Int) -> [String] {
    var result = [String]()
    for i in 1...n {
        var element = ""
        if i % 3 == 0 {
            element += "Fizz"
        }
        if i % 5 == 0 {
            element += "Buzz"
        }
        if element == "" {
            element = String(i)
        }
        result.append(element)
    }
    return result
}

fizzBuzz(17)
struct IntStack {
    var items = [Int]()
    mutating func push(_ item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
}

// 496. Next Greater Element I
func nextGreaterElement(_ findNums: [Int], _ nums: [Int]) -> [Int] {
    var result = [Int]()
    var dic : [Int:Int] = [:]
    var stack = IntStack()
    for num in nums {
        while stack.items.count != 0, let top = stack.items.last, top < num {
            dic[stack.pop()] = num
        }
        stack.push(num)
    }
    for find in findNums {
        if let ele = dic[find] {
            result.append(ele)
        }else{
            result.append(-1)
        }
    }
    return result
}

nextGreaterElement([2,4], [1,2,3,4])

// 463. Island Perimeter
func islandPerimeter(_ grid: [[Int]]) -> Int {
    guard !grid.isEmpty else {
        return 0
    }
    var result = 0
    for (i,row) in grid.enumerated() {
        for (j,cell) in row.enumerated() {
            if cell == 1{
                result += 4
                if j > 0,grid[i][j-1] == 1 {
                    result -= 2
                }
                if i > 0, grid[i-1][j] == 1{
                    result -= 2
                }
            }
        }
    }
    return result
}

islandPerimeter([[0,1,0,0],
                 [1,1,1,0],
                 [0,1,0,0],
                 [1,1,0,0]])

// 292. Nim Game
func canWinNim(_ n: Int) -> Bool {
    let nn = String(n)
    nn.substring(from: nn.index(before: nn.endIndex))
    let num = Int(nn)!
    return num % 4 != 0
}

// 485. Max Consecutive Ones
func findMaxConsecutiveOnes(_ nums: [Int]) -> Int {
    var result = 0
    var max = 0
    for num in nums {
        if num == 1 {
            max += 1
        }else{
            if max > result {
                result = max
            }
            max = 0
        }
    }
    return result
}

// 136. Single Number
func singleNumber(_ nums: [Int]) -> Int {
    var numSet = Set<Int>()
    for num in nums {
        let result = numSet.insert(num)
        if result.inserted == false {
            numSet.remove(result.memberAfterInsert)
        }
    }
    if numSet.count != 0 {
        return numSet.first!
    }else{
        return 0
    }
}

// 520. Detect Capital
func detectCapitalUse(_ word: String) -> Bool {
    var upcaseCount = 0
    for c in word.characters {
        if c >= "A" && c <= "Z" {
            upcaseCount += 1
        }
    }
    if upcaseCount == 1 {
        let first = word.characters.first!
        return  first >= "A" && first <= "Z"
    }else{
        return upcaseCount == word.characters.count || upcaseCount == 0
    }
    
}

detectCapitalUse("Linshiwei")

// 448. Find All Numbers Disappeared in an Array
func findDisappearedNumbers( _ nums: inout [Int]) -> [Int] {
    var result = [Int]()
    for i in 0...nums.count-1 {
        let index = abs(nums[nums[i]-1])-1
        let number = nums[index]
        if number < 0 {
            print(1)
        }
        nums[index] = 1
    }
    for (j,num) in nums.enumerated() {
        if num > 0 {
            result.append(j+1)
        }
    }
    return result
}

// Definition for a binary tree node.
public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init(_ val: Int) {
        self.val = val
            self.left = nil
            self.right = nil
        }
    }

// 104. Maximum Depth of Binary Tree
func maxDepth(_ root: TreeNode?) -> Int {
    guard let root = root else {
        return 0
    }
    let left = maxDepth(root.left)
    let right = maxDepth(root.right)
    return left > right ? left + 1 : right + 1
    
}

// 371. Sum of Two Integers
func getSum(_ a: Int, _ b: Int) -> Int {
    //&和移位记录进位，异或记录无进位的加法。再把两者相加。
    return b == 0 ? a : getSum(a^b, (a&b)<<1)
}

getSum(4, 6)

// 226. Invert Binary Tree
func invertTree(_ root: TreeNode?) -> TreeNode? {
    guard let root = root else {
        return nil
    }
    let temp = root.left
    root.left = invertTree(root.right)
    root.right = invertTree(temp)
    return root
}

// 492. Construct the Rectangle
func constructRectangle(_ area: Int) -> [Int] {
    if area == 0 {return [0,0]}
    var a = Int(sqrt(Double(area)))
    while(area%a != 0){
        a -= 1
    }
    return [a,area/a]
}

// 283. Move Zeroes
func moveZeroes(_ nums: inout [Int]) {
    var j = 0
    for (i,num) in nums.enumerated() {
        if num != 0 {
            let temp = num
            nums[i] = nums[j]
            nums[j] = temp
            j += 1
        }
    }
}

// 530. Minimum Absolute Difference in BST
func getMinimumDifference(_ root: TreeNode?) -> Int {
    var min = Int.max
    var previous : Int?
    func inorderTraverse(root: TreeNode?) {
        guard let root = root else {
            return
        }
        inorderTraverse(root: root.left)
        //先遍历左边，遍历左边的时候，preivous 一直都是nil，一旦左边都遍历完了，开始从下往上遍历右边，这时候 previous 开始有数
        if previous != nil {
            let delta = root.val - previous!
            min = min > delta ? delta : min
        }
        previous = root.val
        inorderTraverse(root: root.right)
    }
    inorderTraverse(root: root)
    return min
}

// 506. Relative Ranks
func findRelativeRanks(_ nums: [Int]) -> [String] {
    var result = nums.sorted()
    var resultString = [String]()
    for i in (0...result.count-1) {
        if i == 0 {
            resultString.append("Gold Medal")
        }
        if i == 1 {
            resultString.append("Silver Medal")
        }
        if i == 2 {
            resultString.append("Bronze Medal")
        }
        if i > 2 {
            resultString.append(String(result[i]))
        }
    }
    return resultString
}

findRelativeRanks([10,3,8,9,4])

// 167. Two Sum II - Input array is sorted
func twoSum(_ numbers: [Int], _ target: Int) -> [Int] {
    var low = 0
    var hight = numbers.count - 1
    while numbers[low] + numbers[hight] != target {
        let sum = numbers[low] + numbers[hight]
        if sum > target {
            hight -= 1
        }else{
            low += 1
        }
    }
    return [low + 1, hight + 1]
}

// 455. Assign Cookies
func findContentChildren(_ g: [Int], _ s: [Int]) -> Int {
    guard !s.isEmpty else { return 0 }
    let gg = g.sorted()
    let ss = s.sorted()
    var i = 0
    for j in 0...ss.count-1 {
        if i < gg.count && gg[i] <= ss[j]{
            i += 1
        }
    }
    return i
}

// 453. Minimum Moves to Equal Array Elements
func minMoves(_ nums: [Int]) -> Int {
    var sum = 0
    var min = Int.max
    for num in nums {
        sum += num
        if min > num {
            min = num
        }
    }
    return sum - min * nums.count
}

// 383. Ransom Note
func canConstruct(_ ransomNote: String, _ magazine: String) -> Bool {
    var array = [Int](repeatElement(0, count: 26))
    magazine.unicodeScalars.map{ value in
        array[Int(value.value-97)] += 1
    }
    var result = true
    ransomNote.unicodeScalars.map{ v in
        array[Int(v.value-97)] -= 1
        if array[Int(v.value-97)] < 0 {
            result = false
        }
    }
    return result
}

canConstruct("aa", "ab")

// 404. Sum of Left Leaves
func sumOfLeftLeaves(_ root: TreeNode?) -> Int {
    var sum = 0
        guard let root = root else {
            return 0
        }
        if let left = root.left {
            if left.left == nil && left.right == nil {
                sum += left.val
            }
            sum += sumOfLeftLeaves(left)
        }
        if let right = root.right {
            sum += sumOfLeftLeaves(right)
        }
    return sum
}

// 387. First Unique Character in a String
func firstUniqChar(_ s: String) -> Int {
    var array = [Int](repeatElement(0, count: 26))
    s.unicodeScalars.map{c in
        array[Int(c.value-UnicodeScalar("a")!.value)] += 1
    }
    for (i,a) in s.unicodeScalars.enumerated() {
        if array[Int(a.value-UnicodeScalar("a")!.value)] == 1 {
            return i
        }
    }
    return -1
}

firstUniqChar("leetcode")

// 349. Intersection of Two Arrays
func intersection(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
    let nums1Set = Set<Int>(nums1)
    let nums2Set = Set<Int>(nums2)
    let intersection = nums1Set.intersection(nums2Set)
    return Array(intersection)
}

// 504. Base 7 
func convertToBase7(_ num: Int) -> String {
    return String(num,radix:7)
}

convertToBase7(100)

// 171. Excel Sheet Column Number
func titleToNumber(_ s: String) -> Int {
    var result = 0
    for c in s.unicodeScalars {
        result = result * 26 + (Int(c.value-UnicodeScalar("A")!.value) + 1)
    }
    return result
}

// 100. Same Tree
func isSameTree(_ p: TreeNode?, _ q: TreeNode?) -> Bool {
    if p == nil && q == nil {
        return true
    }
    guard let p = p,let q = q else {
        return false
    }
    return p.val == q.val && isSameTree(p.left,q.left) && isSameTree(p.right, q.right)
}

// 242. Valid Anagram
func isAnagram(_ s: String, _ t: String) -> Bool {
    let count = s.characters.count
    guard count == t.characters.count else {
        return false
    }
    if s == "" && t == "" {
        return true
    }
    var dic = [Character:Int]()
    
    s.characters.map{ c in
        dic[c] = dic[c] == nil ? 1 : dic[c]! + 1
    }
    for c in t.characters {
        if let value = dic[c],value > 0 {
            dic[c] = dic[c]!-1
        }else{
            return false
        }
    }
    for value in dic.values {
        if value != 0 {
            return false
        }
    }
    return true
}

isAnagram("anagram", "nagaram")

// 217. Contains Duplicate
func containsDuplicate(_ nums: [Int]) -> Bool {
    let set = Set<Int>(nums)
    if set.count == nums.count {
        return false
    }else{
        return true
    }
}

// 401. Binary Watch
func readBinaryWatch(_ num: Int) -> [String] {
    var result = [String]()
    for i in 0...11 {
        let iString = String(i,radix:2)
        var count = 0
        iString.characters.map{ c in
            if c == "1" {
                count += 1
            }
        }
        if count > num {
            continue
        }else if count == num{
            let string = String(format: "%01d:00", i)
            result.append(string)
            continue
        }
        for j in 0...59 {
            var jcount = count
            let jString = String(j,radix:2)
            jString.characters.map{ c in
                if c == "1" {
                    jcount += 1
                }
            }
            if jcount == num {
                let string = String(format: "%01d:%02d", i,j)
                result.append(string)
            }
        }
    }
    return result
}

readBinaryWatch(1)

// Definition for singly-linked list.
public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

// 206. Reverse Linked List
func reverseList(_ head: ListNode?) -> ListNode? {
    var headv = head
    var newHead: ListNode?
    while headv != nil {
        let next = headv?.next
        headv?.next = newHead
        newHead = headv
        headv = next
    }
    return newHead
}

// 268. Missing Number
func missingNumber(_ nums: [Int]) -> Int {
    var result = 0
    for i in 0...nums.count-1 {
        result = result^i^nums[i]
    }
    return result^nums.count
}

missingNumber([0, 1, 3])

// 447. Number of Boomerangs
func numberOfBoomerangs(_ points: [[Int]]) -> Int {
    var result = 0
    func distance(_ a: [Int],_ b: [Int])-> Int {
        let dx = a[0]-b[0]
        let dy = a[1]-b[1]
        return dx*dx+dy*dy
    }
    for i in points {
        var dic = [Int:Int]()
        for j in points {
            if i == j {
                continue
            }
            let d = distance(i, j)
            dic[d] = dic[d] == nil ? 1 : dic[d]! + 1
        }
        for v in dic.values {
            result += v*(v-1)
        }
    }  
    return result
}
numberOfBoomerangs([[0,0],[1,0],[2,0]])

// 350. Intersection of Two Arrays II
func intersect(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
    var dic = [Int:Int]()
    nums1.map{ num in
        dic[num] = dic[num] == nil ? 1 : dic[num]! + 1
    }
    var result = [Int]()
    print(dic)
    nums2.map{ num in
        if let number = dic[num],number > 0 {
            result.append(num)
            dic[num] = number - 1
        }
    }
    return result
    
}

intersect([1,2], [2,1])

// 108. Convert Sorted Array to Binary Search Tree
func sortedArrayToBST(_ nums: [Int]) -> TreeNode? {
    func helper(_ nums: [Int], low: Int, high: Int) -> TreeNode?{
        if low > high {
            return nil
        }
        let mid = (low + high)/2
        let newTree = TreeNode(nums[mid])
        newTree.left = helper(nums, low: low, high: mid - 1)
        newTree.right = helper(nums, low: mid + 1, high: high)
        return newTree
    }
    return helper(nums, low: 0, high: nums.count - 1)
}

// 405. Convert a Number to Hexadecimal
func toHex(_ num: Int) -> String {
    if num == 0 {
        return "0"
    }
    var result = ""
    var number = UInt32(bitPattern: Int32(num))
    let map = ["0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f"]
    while number != 0 {
        let index = number & 15
        result = map[Int(index)] + result
        number = number >> 4
    }
    return result
}

toHex(256)

// 122. Best Time to Buy and Sell Stock II
func maxProfit(_ prices: [Int]) -> Int {
    var sum = 0
    guard prices.count >= 2 else {
        return 0
    }
    for i in 0...prices.count - 2 {
        if prices[i] < prices[i+1] {
            sum += prices[i+1] - prices[i]
        }
    }
    return sum
}

// 121. Best Time to Buy and Sell Stock
func maxProfit121(_ prices: [Int]) -> Int {
    var maxCur = 0
    var maxSoFar = 0
    for i in 0...prices.count - 1 {
        maxCur += prices[i] - prices[i-1]
        if maxCur < 0 {
            maxCur = 0
        }
        maxSoFar = maxCur > maxSoFar ? maxCur : maxSoFar
    }
    return maxSoFar
}

// 543. Diameter of Binary Tree
func diameterOfBinaryTree(_ root: TreeNode?) -> Int {
    var diameter = 0
    func calculateDiameter(_ root: TreeNode?)->Int{
        guard let root = root else {
            return 0
        }
        let left = calculateDiameter(root.left)
        let right = calculateDiameter(root.right)
        diameter = diameter > left + right ? diameter : left + right
        return left > right ? left + 1 : right + 1
        
    }
    calculateDiameter(root)
    return diameter
}

