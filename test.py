def minion_game(string):
  # your code goes here
  #print(len(string))
  kevin = 0
  stuart = 0
  vowels = ["A","E","I","O","U"]
  for i in range(len(string)):
    for j in range(i+1,len(string)+1):
      if string[i:j][0] in vowels:
        kevin += 1
      else:
        stuart += 1
    
  if kevin == stuart:
    print("Draw")
  elif kevin > stuart:
    print("Kevin",kevin)
  else:
   print("Stuart",stuart)
        
def minion_game2(string):
    vowels = 'AEIOU'

    kevsc = 0
    stusc = 0
    print(len(s))
    for i in range(len(s)):
        print("i=",i)
        print("s[i]=",s[i])
        if s[i] in vowels:
          print("adding to kevin",len(s)-i)
          kevsc += (len(s)-i)
        else:
          print("adding to stu",len(s)-i)
          stusc += (len(s)-i)

    if kevsc > stusc:
        print("Kevin", kevsc)
    elif kevsc < stusc:
        print("Stuart", stusc)
    else:
        print("Draw")
  
if __name__ == '__main__':
  s = input()
  minion_game2(s)