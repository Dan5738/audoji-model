import asyncio
import whisper
from decouple import config
from asgiref.sync import sync_to_async


class AudojiCreator:
    def __init__(self, audio_file_url):
        self.audio_file_url = audio_file_url
        self.model = whisper.load_model(
                "large-v3"
            )  # "base", "medium", "large-v1", "large-v2", "large-v3", "large"

    async def transcribe_audio(self):
        # Run the synchronous transcribe method asynchronously
        result = await sync_to_async(self.model.transcribe)(self.audio_file_url)
        return result


if __name__ == "__main__":
    import sys

    # Get the audio file URL from command-line arguments
    audio_file_url = sys.argv[1]

    # Create an instance of AudojiCreator
    creator = AudojiCreator(audio_file_url)

    # Transcribe the audio file
    result = asyncio.run(creator.transcribe_audio())
    print(result)
