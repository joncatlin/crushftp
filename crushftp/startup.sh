# If there is no crushadmin user then create one with a default password
if [[ ! -d /var/opt/CrushFTP9/users/MainUsers/crushadmin ]] ; then
    echo "Creating default admin..."
    cd /var/opt/CrushFTP9 && java -jar /var/opt/CrushFTP9/CrushFTP.jar -a "crushadmin" "crushadmin"
fi

# Start the crush service
echo "Starting crush..."
java -Xmx1024m -jar CrushFTP.jar -d

