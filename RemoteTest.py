#!/usr/bin/python
# -*- coding: utf-8 -*-
if __name__ == '__main__':
	# The following code allows this test to be invoked outside the harness and should be left unchanged
	import os, sys
	args = [os.path.realpath(os.path.expanduser("/Users/testing/xRaft/Harness/Source/raft")), "-f"] + sys.argv
	os.execv(args[0], args)

"""
RemoteTest

Contact: (Sindhu) (Muralidharan)
2010/01/05
"""

# This is a RAFT test. For more information see http://dzone200/wiki/RAFT
testDescription  = ""                 # Add a brief description of test functionality
testVersion      = "0.1"              # Your test version must be changed if you change testCustomDBSpec or testState
testState        = DevelopmentState   # Possible values: DevelopmentState, ProductionState
testCustomDBSpec = {}                 # for the exceptional case when custom data fields are needed (see wiki)

import pexpect, sys

Machine1 = "17.226.13.30"
Machine2 = "17.226.13.31"
sshmachine1 = '/usr/bin/ssh offshore@17.226.13.30'
sshmachine2 = '/usr/bin/ssh offshore@17.226.13.30'

ssh_tunnel = 0

def runTest(params):
	# Your testing code here
	
	RemoteLogin()

def RemoteLogin():
    try:
        ssh_tunnel = pexpect.spawn (sshmachine1)
		#Required for debugging
        #ssh_tunnel.logfile = sys.stdout
        #ssh_tunnel.logfile_read = sys.stdout
        #fout = file('mylog.txt','w')
        #ssh_tunnel.logfile = fout 

        passStatus = ssh_tunnel.expect (['assword:','\?'])
        if passStatus == 0:
			time.sleep (0.1)
			ssh_tunnel.sendline ('offshore')
        else:
			ssh_tunnel.sendline ('yes')			
			time.sleep (0.1)
			ssh_tunnel.expect ('assword:')
			ssh_tunnel.sendline ('offshore')
	
	
	TC1 = AddressBookSync(ssh_tunnel)
	
	
	if TC1 == 0:
		logFail()
	else:
		print "Following scenarios passed as part of this testcase"
		print " -  Contact Sync in SnowLeopard"
		print "    * Email, Name, Phone validation"
		print "    * Sync validation"
	
		logPass()
   

    except Exception, e:
        print str(e)
	
     
  
def AddressBookSync(ssh_tunnel):
	print "################# FIRST PART OF TESTCASE HAS STARTED ###################"
	ssh_tunnel.expect ('$')
	ssh_tunnel.sendline ('python ~xupdate/raftsandbox/raft SyncAddressBookSingleContact Module 1')
	print "Creation of contacts followed by Sync : Started on",Machine1
	#time.sleep (120)

	status1 = ssh_tunnel.expect (['Recording test result: FAILURE', 'Recording test result: PASS', pexpect.EOF, pexpect.TIMEOUT], timeout=180)

	if status1 == 0:
		print "Remote Test Failure"
		return 0
	elif status1 == 1:
		#print "Following scenarios passed on",Machine1
		#print "Address group creation"
		#print "Address card creation"
		#print "Sync the contacts details onto Woa"
		#print "#########################################"
		print " Testcase 1 successful on : ", Machine1
		print "#########################################"

		#return 1
		ssh_tunnel.close()
		
		print "################## SECOND PART OF TESTCASE ###################### "
	
		ssh_tunnel2 = pexpect.spawn (sshmachine2)
		#ssh_tunnel2.logfile = sys.stdout
		
		#ssh_tunnel2.logfile = sys.stdout
	#ssh_tunnel.logfile_read = sys.stdout
	#fout = file('mylog.txt','w')
	#ssh_tunnel.logfile = fout 

		passStatus = ssh_tunnel2.expect (['assword:','\?'])
		if passStatus == 0:
			time.sleep (0.1)
			ssh_tunnel2.sendline ('offshore')
		else:
			ssh_tunnel2.sendline ('yes')			
			time.sleep (0.1)
			ssh_tunnel2.expect ('assword:')
			ssh_tunnel2.sendline ('offshore')

	
	
		ssh_tunnel2.expect ('$')
		ssh_tunnel2.sendline ('python ~xupdate/raftsandbox/raft SyncAddressBookSingleContact Module 2')
		print "Sync followed by Validation of synced data : Started on",Machine2
		#time.sleep (120)

		status = ssh_tunnel2.expect (['Recording test result: FAILURE', 'Recording test result: PASS', pexpect.EOF, pexpect.TIMEOUT], timeout=120)

		if status == 0:
			print "Remote Test2 Failure"
			return 0
		elif status == 1:
			#print "Following scenarios passed on",Machine2
			#print "Sync the contacts details onto Computer"
			#print "Address card validation"
			#print "#########################################"
			print " Testcase 2 successful on : ", Machine2
			print "#########################################"
			return 1
		else:
			print "Timeout ....."
			return 0
		ssh_tunnel2.close()

		#logFail()			
	else:
		print "Timeout ..."
		return 0
