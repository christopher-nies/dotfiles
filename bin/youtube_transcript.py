"""
youtube_transcript.py

This script fetches the transcript of a YouTube video and corrects its punctuation using OpenAI's
GPT-4o-mini model.
"""

import sys
import os
from urllib.parse import urlparse, parse_qs
from youtube_transcript_api import YouTubeTranscriptApi
import openai

# Your OpenAI API key
openai.api_key = os.getenv('OPENAI_API_KEY')

def extract_video_id(url):
    parsed_url = urlparse(url)
    if parsed_url.hostname == 'youtu.be':
        return parsed_url.path[1:]  # Skip the leading slash
    elif parsed_url.hostname in ('www.youtube.com', 'youtube.com'):
        if parsed_url.path == '/watch':
            return parse_qs(parsed_url.query)['v'][0]
        elif '/embed/' in parsed_url.path:
            return parsed_url.path.split('/embed/')[1]
        elif '/v/' in parsed_url.path:
            return parsed_url.path.split('/v/')[1]
    return None  # Invalid URL

def fetch_transcript(video_id):
    try:
        transcript = YouTubeTranscriptApi.get_transcript(video_id)
        return ' '.join([entry['text'] for entry in transcript])
    except Exception as e:
        print(f"Error fetching transcript: {e}")
        return None

def correct_punctuation(text):
    response = openai.chat.completions.create(
        messages=[
            {
				"role": "user", 
				"content": f"Correct the punctuation in the following text with respect to the language ued. Respond only with the corrected transcript and no additional text: '{text}'"
			}
        ],
		model="gpt-4o-mini",
    )
    return response.choices[0].message.content
    
def main():
    if len(sys.argv) != 2:
        print("Usage: python your_script.py <YouTube_URL>")
        sys.exit(1)

    youtube_url = sys.argv[1]
    video_id = extract_video_id(youtube_url)

    if not video_id:
        print("Invalid YouTube URL. Please provide a valid URL.")
        sys.exit(1)
        
    transcript = fetch_transcript(video_id)

    if transcript:
        corrected_text = correct_punctuation(transcript)
        print("Corrected Transcript:")
        print(corrected_text)

if __name__ == "__main__":
    main()
