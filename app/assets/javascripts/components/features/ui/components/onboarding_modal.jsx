import { connect } from 'react-redux';
import PureRenderMixin from 'react-addons-pure-render-mixin';
import ImmutablePropTypes from 'react-immutable-proptypes';
import { defineMessages, injectIntl, FormattedMessage } from 'react-intl';
import Permalink from '../../../components/permalink';
import { TransitionMotion, spring } from 'react-motion';
import ComposeForm from '../../compose/components/compose_form';
import Search from '../../compose/components/search';
import NavigationBar from '../../compose/components/navigation_bar';
import ColumnHeader from './column_header';
import Immutable from 'immutable';

const messages = defineMessages({
  home_title: { id: 'column.home', defaultMessage: 'Origin' },
  notifications_title: { id: 'column.notifications', defaultMessage: 'Notifications' },
  local_title: { id: 'column.community', defaultMessage: 'Community activity' },
  federated_title: { id: 'column.public', defaultMessage: 'Global activity' }
});

const PageOne = ({ acct, domain }) => (
  <div className='onboarding-modal__page onboarding-modal__page-one'>
    <div style={{ flex: '0 0 auto' }}>
      <div className='onboarding-modal__page-one__elephant-friend' />
    </div>

    <div>
      <h1><FormattedMessage id='onboarding.page_one.welcome' defaultMessage='Hi, you found Oulipo Mastodon!' /></h1>
      <p><FormattedMessage id='onboarding.page_one.federation' defaultMessage='Mastodon is a social hub that for all.' /></p>
      <p><FormattedMessage id='onboarding.page_one.handle' defaultMessage='This is {domain}, an instantiation among many Mastodon instantiations. Your full alias is {handle}' values={{ domain, handle: <strong>{acct}@{domain}</strong> }}/></p>
    </div>
  </div>
);

PageOne.propTypes = {
  acct: React.PropTypes.string.isRequired,
  domain: React.PropTypes.string.isRequired
};

const PageTwo = () => (
  <div className='onboarding-modal__page onboarding-modal__page-two'>
    <div className='figure non-interactive'>
      <ComposeForm
        text='Awoo! #introductions'
        suggestions={Immutable.List()}
        mentionedDomains={[]}
        onChange={() => {}}
        onSubmit={() => {}}
        onPaste={() => {}}
        onPickEmoji={() => {}}
        onChangeSpoilerText={() => {}}
        onClearSuggestions={() => {}}
        onFetchSuggestions={() => {}}
        onSuggestionSelected={() => {}}
      />
    </div>

    <p><FormattedMessage id='onboarding.page_two.compose' defaultMessage='Draft posts in your composition column. You can upload photos, control visibility, and add tricky topic warnings.' /></p>
  </div>
);

const PageThree = ({ me, domain }) => (
  <div className='onboarding-modal__page onboarding-modal__page-three'>
    <div className='figure non-interactive'>
      <Search
        value=''
        onChange={() => {}}
        onSubmit={() => {}}
        onClear={() => {}}
        onShow={() => {}}
      />

      <div className='pseudo-drawer'>
        <NavigationBar account={me} />
      </div>
    </div>

    <p><FormattedMessage id='onboarding.page_three.search' defaultMessage="Try using our inquiry bar to find accounts and look at hashtags, such as {illustration} and {introductions}. To look for an account  who is not on this instantiation, look for that account's full alias." values={{ illustration: <Permalink to='/timelines/tag/drilipo' href='/tags/drilipo'>#drilipo</Permalink>, introductions: <Permalink to='/timelines/tag/introductions' href='/tags/introductions'>#introductions</Permalink> }}/></p>
    <p><FormattedMessage id='onboarding.page_three.profile' defaultMessage='Modify your bio to upload an avatar, bio, and display alias. This is also a spot for additional options and configurations.' /></p>
  </div>
);

PageThree.propTypes = {
  me: ImmutablePropTypes.map.isRequired,
  domain: React.PropTypes.string.isRequired
};

const PageFour = ({ domain, intl }) => (
  <div className='onboarding-modal__page onboarding-modal__page-four'>
    <div className='onboarding-modal__page-four__columns'>
      <div className='row'>
        <div>
          <div className='figure non-interactive'><ColumnHeader icon='home' type={intl.formatMessage(messages.home_title)} /></div>
          <p><FormattedMessage id='onboarding.page_four.home' defaultMessage='Origin activity shows posts from folks you follow'/></p>
        </div>

        <div>
          <div className='figure non-interactive'><ColumnHeader icon='bell' type={intl.formatMessage(messages.notifications_title)} /></div>
          <p><FormattedMessage id='onboarding.page_four.notifications' defaultMessage='Notifications show if anybody boosts, stars, or talks with you' /></p>
        </div>
      </div>

      <div className='row'>
        <div>
          <div className='figure non-interactive' style={{ marginBottom: 0 }}><ColumnHeader icon='globe' type={intl.formatMessage(messages.federated_title)} /></div>
        </div>

        <div>
          <div className='figure non-interactive' style={{ marginBottom: 0 }}><ColumnHeader icon='users' type={intl.formatMessage(messages.local_title)} /></div>
        </div>
      </div>

      <p><FormattedMessage id='onboarding.page_five.public_timelines' defaultMessage='Global activity lists public posts from all accounts who anybody on {domain} follow. Community activity is similar, but only shows accounts on {domain}.' values={{ domain }} /></p>
    </div>
  </div>
);

PageFour.propTypes = {
  domain: React.PropTypes.string.isRequired,
  intl: React.PropTypes.object.isRequired
};

const PageSix = ({ admin }) => {
  let adminSection = '';

  if (admin) {
    adminSection = (
      <p>
        <FormattedMessage id='onboarding.page_six.admin' defaultMessage="Your instantiation's admin is {admin}." values={{ admin: <Permalink href={admin.get('url')} to={`/accounts/${admin.get('id')}`}>@{admin.get('acct')}</Permalink> }} />
        <br />
        <FormattedMessage id='onboarding.page_six.read_guidelines' defaultMessage='Do look at our FAQ and {guidelines}!' values={{ guidelines: <a href='/about/more' target='_blank'><FormattedMessage id='onboarding.page_six.guidelines' defaultMessage='community social contract' /></a> }}/>
      </p>
    );
  }

  return (
    <div className='onboarding-modal__page onboarding-modal__page-six'>
      <h1><FormattedMessage id='onboarding.page_six.almost_done' defaultMessage='Almost got it...' /></h1>
      {adminSection}
      <p><FormattedMessage id='onboarding.page_six.github' defaultMessage='Mastodon is "FOSS". You can add contributions or log a bug on GitHub at {github}.' values={{ github: <a href='https://github.com/tootsuite/mastodon' target='_blank' rel='noopener'>GitHub</a> }} /></p>
      <p><FormattedMessage id='onboarding.page_six.apps_available' defaultMessage='You can find {apps} for iOS and Android. And now... Bon Oulitoot!' values={{ apps: <a href='https://github.com/tootsuite/documentation/blob/master/Using-Mastodon/Apps.md' target='_blank' rel='noopener'><FormattedMessage id='onboarding.page_six.various_app' defaultMessage='various apps' /></a> }} /></p>
    </div>
  );
};

PageSix.propTypes = {
  admin: ImmutablePropTypes.map
};

const mapStateToProps = state => ({
  me: state.getIn(['accounts', state.getIn(['meta', 'me'])]),
  admin: state.getIn(['accounts', state.getIn(['meta', 'admin'])]),
  domain: state.getIn(['meta', 'domain'])
});

const OnboardingModal = React.createClass({

  propTypes: {
    onClose: React.PropTypes.func.isRequired,
    intl: React.PropTypes.object.isRequired,
    me: ImmutablePropTypes.map.isRequired,
    domain: React.PropTypes.string.isRequired,
    admin: ImmutablePropTypes.map
  },

  getInitialState () {
    return {
      currentIndex: 0
    };
  },

  mixins: [PureRenderMixin],

  handleSkip (e) {
    e.preventDefault();
    this.props.onClose();
  },

  handleDot (i, e) {
    e.preventDefault();
    this.setState({ currentIndex: i });
  },

  handleNext (maxNum, e) {
    e.preventDefault();

    if (this.state.currentIndex < maxNum - 1) {
      this.setState({ currentIndex: this.state.currentIndex + 1 });
    } else {
      this.props.onClose();
    }
  },

  render () {
    const { me, admin, domain, intl } = this.props;

    const pages = [
      <PageOne acct={me.get('acct')} domain={domain} />,
      <PageTwo />,
      <PageThree me={me} domain={domain} />,
      <PageFour domain={domain} intl={intl} />,
      <PageSix admin={admin} />
    ];

    const { currentIndex } = this.state;
    const hasMore = currentIndex < pages.length - 1;

    let nextOrDoneBtn;

    if(hasMore) {
      nextOrDoneBtn = <a href='#' onClick={this.handleNext.bind(null, pages.length)} className='onboarding-modal__nav onboarding-modal__next'><FormattedMessage id='onboarding.next' defaultMessage='Onward' /></a>;
    } else {
      nextOrDoneBtn = <a href='#' onClick={this.handleNext.bind(null, pages.length)} className='onboarding-modal__nav onboarding-modal__done'><FormattedMessage id='onboarding.next' defaultMessage='Finish' /></a>;
    }

    const styles = pages.map((page, i) => ({
      key: i,
      style: { opacity: spring(i === currentIndex ? 1 : 0) }
    }));

    return (
      <div className='modal-root__modal onboarding-modal'>
        <TransitionMotion styles={styles}>
          {interpolatedStyles =>
            <div className='onboarding-modal__pager'>
              {pages.map((page, i) =>
                <div key={i} style={{ opacity: interpolatedStyles[i].style.opacity, pointerEvents: i === currentIndex ? 'auto' : 'none' }}>{page}</div>
              )}
            </div>
          }
        </TransitionMotion>

        <div className='onboarding-modal__paginator'>
          <div>
            <a href='#' className='onboarding-modal__skip' onClick={this.handleSkip}><FormattedMessage id='onboarding.skip' defaultMessage='Skip' /></a>
          </div>

          <div className='onboarding-modal__dots'>
            {pages.map((_, i) => <div key={i} onClick={this.handleDot.bind(null, i)} className={`onboarding-modal__dot ${i === currentIndex ? 'active' : ''}`} />)}
          </div>

          <div>
            {nextOrDoneBtn}
          </div>
        </div>
      </div>
    );
  }

});

export default connect(mapStateToProps)(injectIntl(OnboardingModal));
