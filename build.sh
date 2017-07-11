cd perl5
docker build -t adventure-base .
cd ..
docker build -t adventure-mission .
echo "Assuming everything built OK..."
echo "run this:"
echo "docker run -it adventure-mission"
