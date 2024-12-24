
# app.py
import time

def main():
    with open("/app/output.txt", "w") as f:
        f.write("This is a test file to check Docker and ACI functionality.\n")
        f.write("If you see this file in OneDrive, everything is working fine.\n")
        f.write(f"Timestamp: {time.time()}\n")

if __name__ == "__main__":
    main()
