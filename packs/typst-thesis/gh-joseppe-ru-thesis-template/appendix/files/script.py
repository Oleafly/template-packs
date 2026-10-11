import time

class App:
    def __init__(self):
        self.running = True  

    def run(self):
        try:
            while self.running:
                print("Lauf Forrest")
                time.sleep(1)
        except Exception as e:
            print(f"Hingefallen: {e}")
        finally:
            print("Stop")


    def on_close(self):
        self.running = False
        self.root.quit()



app = App()
app.run()

app.running = False

print("Finished?")
