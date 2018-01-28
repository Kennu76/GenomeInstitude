defmodule Database.UploadController do  
    use Database.Web, :controller
  
    def upload_form(conn, _params) do
        
      render conn, "upload.html"
    end
  
    def upload(conn, %{"upload" => %{"file" => file}}) do  
        # Get the file's extension
        file_extension = Path.extname(file.filename)
        IO.inspect "####################################"
        # Generate the UUID
        #file_uuid = UUID.uuid4(:hex)
      
        
        IO.inspect "####################################"
        # Load the file into memory
        {:ok, file_binary} = File.read(file.path)
        IO.inspect file_binary
        decoded = CSVLixir.parse(file_binary)
        IO.inspect decoded
        conn
        |> put_flash(:success, "File uploaded successfully!")
        |> render("upload.html")
    end
  end  