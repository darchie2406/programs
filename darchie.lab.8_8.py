from numpy import

row = input('enter number of employees')
col = 4

prompt = ['enter employee ID', 'enter hours worked', 'enter hourly pay rate']
format01 = '%5i          %0.2f         %0.2f         %0.2f'

pay = zeros([row, col], float)


def main():
    pay = dataIn()
    printresults(pay)
  for r in range(row):
      for c in range(col-1):
          loop=1
          while loop==1:
              try:
                pay[r,c]=input(prompt[c])
                loop=0

              except:
                print'input was not numeric'
                raw_input('press enter to re-enter')


     if c==2:
        pay[r,c+1]=pay[r,1]*pay[r,2]
  return pay

def printresults(pay)

    print;print
    print'Employee       HrsWkd        Pay Rate          Gross Pay'
    for r in range(row):
        print format01% (pay[r,0],pay[r,1],pay[r,2],pay[r,3])


    return

main()
