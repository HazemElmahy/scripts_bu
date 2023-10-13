#include <chrono>
#include <iostream>
#include <string>
#include <thread>

#ifdef _WIN32
#include <Windows.h>
#else
#include <unistd.h>
#endif

void playAlarm() {
  const char *command =
      "mpv --end=5 --loop=10 /home/hazem/dotfiles/assets/alarm.wav";
  int result = system(command);

  std::this_thread::sleep_for(std::chrono::seconds(3));
  std::cout << "Alarm played!" << std::endl;
}

void startTimer(float minutes, const std::string &subject) {
  std::cout << "Timer started for " << minutes
            << " minutes with subject: " << subject << std::endl;

  auto endTime = std::chrono::steady_clock::now() +
                 std::chrono::duration<float, std::ratio<60>>(minutes);

  while (std::chrono::steady_clock::now() < endTime) {
    auto remainingTime = std::chrono::duration_cast<std::chrono::seconds>(
        endTime - std::chrono::steady_clock::now());
    std::cout << "\rTime remaining: " << remainingTime.count() << " seconds"
              << std::flush;
    std::this_thread::sleep_for(std::chrono::seconds(1));
  }

  std::cout << std::endl; // Move to the next line after the timer ends
  std::cout << "Timer for " << subject << " ended!" << std::endl;
  playAlarm();
}

int main(int argc, char **argv) {
  float minutes = 0.0f;
  std::string subject;

  // Parse command-line arguments
  for (int i = 1; i < argc; i++) {
    std::string arg = argv[i];
    if (arg == "-t") {
      if (i + 1 < argc) {
        minutes = std::stof(argv[++i]);
      } else {
        std::cerr << "Error: -t requires an argument." << std::endl;
        return 1;
      }
    } else if (arg == "-s") {
      if (i + 1 < argc) {
        subject = argv[++i];
      } else {
        std::cerr << "Error: -s requires an argument." << std::endl;
        return 1;
      }
    }
  }

  if (minutes <= 0.0f) {
    std::cerr << "Error: Invalid timer duration." << std::endl;
    return 1;
  }

  if (subject.empty()) {
    std::cerr << "Error: Timer subject not provided." << std::endl;
    return 1;
  }

  std::thread timerThread(startTimer, minutes, subject);
  timerThread.join();

  return 0;
}
