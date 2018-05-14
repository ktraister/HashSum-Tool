#!/bin/bash
#First ask for file with hash sums. if no file exists, create one
#detect length of hash. script supports MD5, SHA1, SHA224, SHA256, SHA384, SHA512

echo "Hash sum file?"
echo "Don't be shy; tab completion works!"
read -e file

if [ -f $file ] ; then
	
	while read line ; do
		echo 
		length=$( echo $line | cut -d ' ' -f 1 | wc -m )
		new_file=$( echo $line | cut -d ' ' -f 2 )
		
		if [ ! -f $new_file ] ; then
			length=0
		fi
		#if [ $length -eq 11 ] ; then
		#	echo 'cksum detected'
		#	echo 'WARNING! ALGORITHM IS NOT SECURE. SHA2xx or SHA3xx IS RECOMMENDED.'
		#	echo $line
		#	new_line=$(cksum $new_file )
		#	echo $new_line
		#	if [ "$line" = "$new_line" ] ; then
		#		echo 'Sums match!'
		#	else 
		#		echo 'Sums DONT match! Download it again!'
		#	fi

		if [ $length -eq 33 ] ; then
			echo 'MD5 sum detected'
			echo 'WARNING! ALGORITHM IS NOT SECURE. SHA224, SHA256, SHA384 or SHA512 IS RECOMMENDED.'
			echo $line
			echo "md5summing $new_file"
			new_line=$(md5sum $new_file )
			echo $new_line
			if [ "$line" = "$new_line" ] ; then
				echo 'Sums match!'
			else 
				echo 'Sums DONT match! Download it again!'
			fi
		
		elif [ $length -eq  41 ] ; then 
			echo 'SHA1 sum detected'
			echo 'WARNING! ALGORITHM IS NOT SECURE. SHA224, SHA256, SHA384 or SHA512 IS RECOMMENDED.'
			echo $line
			new_line=$(sha1sum $new_file )
			echo $new_line
			if [ "$line" = "$new_line" ] ; then
				echo 'Sums match!'
			else
				echo 'Sums DONT match! Download it again!'
			fi
		

		elif [ $length -eq 57 ] ; then
			echo 'SHA224 sum detected'
			echo $line
			new_line=$(sha224sum $new_file )
			echo $new_line
			if [ "$line" = "$new_line" ] ; then
				echo 'Sums match!'
			else
				echo 'Sums DONT match! Download it again!'
			fi

		elif [ $length -eq 65 ] ; then
			echo 'SHA256 sum detected'
			echo $line
			new_line=$(sha256sum $new_file )
			echo $new_line
			if [ "$line" = "$new_line" ] ; then
				echo 'Sums match!'
			else
				echo 'Sums DONT match! Download it again!'
			fi

		elif [ $length -eq 97 ] ; then
			echo 'SHA384 sum detected'
			echo $line
			new_line=$(sha384sum $new_file )
			echo $new_line
			if [ "$line" = "$new_line" ] ; then
				echo 'Sums match!'
			else
				echo 'Sums DONT match! Download it again!'
			fi

		elif [ $length -eq 129 ] ; then
			echo 'SHA512 sum detected'
			echo $line
			new_line=$(512sum $new_file )
			echo $new_line
			if [ "$line" = "$new_line" ] ; then
				echo 'Sums match!'
			else
				echo 'Sums DONT match! Download it again!'
			fi
		
		elif [ $length -eq 0 ] ; then
			echo "ooohhh shit dawg" 


		else 
			echo "Unknown hash algorithm detected!"
	
		fi

			
	done < $file


else 
	echo "Hash sum file could not be located!"

fi
	



