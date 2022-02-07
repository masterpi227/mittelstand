#gcloud config set project [PROJECT_ID]
git clone https://github.com/GoogleCloudPlatform/appengine-photoalbum-example.git
cd appengine-photoalbum-example
# env_variables:
#  LANG_TAG: 'it'              <-- change to your favorite language code.
#  TIMESTAMP_TZ: 'Europe/Rome' <-- change to your favorite timezone code.
pip install -r requirements.txt -t lib
gcloud app create
gcloud datastore indexes create index.yaml
gcloud app deploy